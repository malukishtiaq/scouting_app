import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
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
