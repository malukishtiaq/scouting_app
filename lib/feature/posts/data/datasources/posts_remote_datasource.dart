import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../../../../core/common/local_storage.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/constants/website_constants.dart';
import '../request/model/posts_response_model.dart';
import '../request/param/get_posts_param.dart';
import 'iposts_remote_datasource.dart';

@Injectable(as: IPostsRemoteSource)
class PostsRemoteSource extends IPostsRemoteSource {
  // Use centralized configuration
  static String get baseUrl => WebsiteConstants.scoutingApiUrl;

  @override
  Future<Either<AppErrors, PostsResponseModel>> getPosts(
      GetPostsParam param) async {
    try {
      final uri = Uri.parse('$baseUrl/api/posts?page=${param.page}');

      print('🔍 PostsRemoteSource: Fetching posts from: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('🔍 PostsRemoteSource: Response status: ${response.statusCode}');
      print('🔍 PostsRemoteSource: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final model = PostsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(AppErrors.customError(
            message: 'HTTP ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {
      print('🔍 PostsRemoteSource: Error: $e');
      return Left(AppErrors.customError(message: 'Network error: $e'));
    }
  }

  @override
  Future<Either<AppErrors, PostsResponseModel>> getMyPosts(
      GetPostsParam param) async {
    try {
      final token = LocalStorage.authToken;
      if (token == null || token.isEmpty) {
        return const Left(
            AppErrors.unauthorizedError(message: 'User not authenticated'));
      }

      final uri = Uri.parse('$baseUrl/api/me/posts?page=${param.page}');

      print('🔍 PostsRemoteSource: Fetching my posts from: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('🔍 PostsRemoteSource: My posts status: ${response.statusCode}');
      print('🔍 PostsRemoteSource: My posts body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        
        // Check if response has the wrapper format with 'success' and 'data'
        if (jsonResponse['success'] == true && jsonResponse['data'] is Map) {
          // Extract the actual pagination data from the wrapped response
          final paginationData = jsonResponse['data'] as Map<String, dynamic>;
          
          // Transform Laravel polymorphic posts to match our model
          final rawPosts = paginationData['data'] as List? ?? [];
          final transformedPosts = rawPosts.map((post) {
            // Convert Laravel polymorphic format to our expected format
            final postMap = Map<String, dynamic>.from(post);
            
            // Determine media_type from postable_type
            final postableType = postMap['postable_type'] as String?;
            String mediaType = '';
            if (postableType != null) {
              if (postableType.contains('Video')) {
                mediaType = 'video';
              } else if (postableType.contains('Image')) {
                mediaType = 'image';
              } else if (postableType.contains('Audio')) {
                mediaType = 'audio';
              }
            }
            
            // Build media_url from postable_id and type
            String mediaUrl = '';
            final postableId = postMap['postable_id'];
            if (postableId != null && mediaType.isNotEmpty) {
              mediaUrl = '$baseUrl/media/stream/$postableId';
            }
            
            // Add our expected fields
            return {
              'id': postMap['id'],
              'title': postMap['title'] ?? '',
              'description': postMap['body'] ?? '', // Laravel uses 'body' field
              'media_url': mediaUrl,
              'media_type': mediaType,
              'user': postMap['avatar'] ?? '', // Use avatar as user name fallback
              'user_id': postMap['user_id'] ?? 0,
              'user_avatar': postMap['avatar'] ?? '',
              'likes': 0, // These aren't in /api/me/posts response
              'shares': 0,
              'comments': 0,
            };
          }).toList();
          
          // Restructure the pagination data to match PostsResponseModel expectations
          final restructuredData = {
            'data': transformedPosts,
            'links': {
              'first': paginationData['first_page_url'],
              'last': paginationData['last_page_url'],
              'prev': paginationData['prev_page_url'],
              'next': paginationData['next_page_url'],
            },
            'meta': {
              'current_page': paginationData['current_page'] ?? 1,
              'from': paginationData['from'],
              'last_page': paginationData['last_page'] ?? 1,
              'links': paginationData['links'] ?? [],
              'path': paginationData['path'] ?? '',
              'per_page': paginationData['per_page'] ?? 10,
              'to': paginationData['to'],
              'total': paginationData['total'] ?? 0,
            },
          };
          
          final model = PostsResponseModel.fromJson(restructuredData);
          return Right(model);
        } else {
          // Handle direct format (no wrapper)
          final model = PostsResponseModel.fromJson(jsonResponse);
          return Right(model);
        }
      }

      if (response.statusCode == 401) {
        return const Left(AppErrors.unauthorizedError(
            message: 'Unauthorized while fetching my posts'));
      }

      return Left(AppErrors.customError(
        message: 'HTTP ${response.statusCode}: ${response.body}',
      ));
    } catch (e) {
      print('🔍 PostsRemoteSource: My posts error: $e');
      return Left(AppErrors.customError(message: 'Network error: $e'));
    }
  }

  @override
  Future<Either<AppErrors, PostModel>> getPostById(
      GetPostByIdParam param) async {
    try {
      final uri = Uri.parse('$baseUrl/api/posts/${param.postId}');

      print('🔍 PostsRemoteSource: Fetching post by ID from: $uri');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('🔍 PostsRemoteSource: Response status: ${response.statusCode}');
      print('🔍 PostsRemoteSource: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        // API returns {"data": {...}} for single post
        final postData = jsonResponse['data'];
        final model = PostModel.fromJson(postData);
        return Right(model);
      } else {
        return Left(AppErrors.customError(
            message: 'HTTP ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {
      print('🔍 PostsRemoteSource: Error: $e');
      return Left(AppErrors.customError(message: 'Network error: $e'));
    }
  }
}
