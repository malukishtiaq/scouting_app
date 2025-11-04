import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/errors/app_errors.dart';
import '../../../../../mainapis.dart';
import '../../../../../core/common/local_storage.dart';
import '../request/model/reels_response_model.dart';
import '../request/param/get_reels_param.dart';
import 'ireels_remote_datasource.dart';

@Injectable(as: IReelsRemoteSource)
class ReelsRemoteSource extends IReelsRemoteSource {
  @override
  Future<Either<AppErrors, ReelsResponseModel>> getReels(
      GetReelsParam param) async {
    try {
      final accessToken = LocalStorage.authToken;
      if (accessToken == null || accessToken.isEmpty) {
        return Left(
            AppErrors.customError(message: 'Access token not available'));
      }

      print(
          '🔍 ReelsRemoteSource: API URL: ${MainAPIS.websiteUrl}${MainAPIS.apiGetPost}');
      print('🔍 ReelsRemoteSource: Request body: ${param.toMap()}');

      // Use the same approach as the working newsfeed
      final uri = Uri.parse(
          '${MainAPIS.websiteUrl}${MainAPIS.apiGetPost}?access_token=$accessToken');

      // Create multipart request
      final request = http.MultipartRequest('POST', uri);

      // Set headers to match curl behavior
      request.headers['User-Agent'] = 'Dart/3.0 (dart:io)';
      request.headers['Accept'] = '*/*';

      // Add form fields exactly like the working newsfeed
      request.fields['server_key'] = MainAPIS.serverKey;
      request.fields['type'] = param.type ?? 'get_news_feed';
      request.fields['limit'] = param.limit ?? '10';
      request.fields['after_post_id'] = param.offset ?? '0';
      if (param.adId != null && param.adId!.isNotEmpty) {
        request.fields['ad_id'] = param.adId!;
      }
      if (param.postType != null && param.postType!.isNotEmpty) {
        request.fields['post_type'] = param.postType!;
      }

      print('🔍 ReelsRemoteSource: Sending request to: $uri');
      print('🔍 ReelsRemoteSource: Form fields: ${request.fields}');

      // Send the request
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('🔍 ReelsRemoteSource: Response status: ${response.statusCode}');
      print('🔍 ReelsRemoteSource: Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final model = ReelsResponseModel.fromJson(jsonResponse);
        return Right(model);
      } else {
        return Left(AppErrors.customError(
            message: 'HTTP ${response.statusCode}: ${response.body}'));
      }
    } catch (e) {
      print('🔍 ReelsRemoteSource: Error: $e');
      return Left(AppErrors.customError(message: 'Network error: $e'));
    }
  }

  @override
  Future<Either<AppErrors, ReelsResponseModel>> getMoreReels(
      GetReelsParam param) async {
    // Use the same implementation as getReels for consistency
    return await getReels(param);
  }
}
