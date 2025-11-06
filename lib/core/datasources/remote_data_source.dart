import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:scouting_app/core/common/extensions/logger_extension.dart';

import '../../di/service_locator.dart';
import '../constants/enums/http_method.dart';
import '../errors/app_errors.dart';
import '../models/base_model.dart';
import '../net/create_model_interceptor/create_model.interceptor.dart';
import '../net/create_model_interceptor/default_create_model_inteceptor.dart';
import '../net/create_model_interceptor/primative_create_model_interceptor.dart';
import '../net/http_client.dart';
import '../net/models_factory.dart';
import '../net/response_validators/default_response_validator.dart';
import '../net/response_validators/list_response_validator.dart';
import '../net/response_validators/response_validator.dart';
import '../params/base_params.dart';
import '../data/cache/generic_cache_service.dart';

class RemoteDataSource {
  Future<Either<AppErrors, T>> requestUploadFile<T extends BaseModel>({
    required T Function(dynamic json) converter,
    required String url,
    required String fileKey,
    required String filePath,
    MediaType? mediaType,
    Map<String, dynamic>? data,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool withAuthentication = false,
    bool withTenants = false,
    CancelToken? cancelToken,
    ResponseValidator? responseValidator,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    String? baseUrl,
    CreateModelInterceptor createModelInterceptor =
        const DefaultCreateModelInterceptor(),
    bool enableLogging = false, // Add parameter to control per-method logging
  }) async {
    // Register the response.
    ModelsFactory().registerModel(
      T.toString(),
      converter,
      createModelInterceptor.toString(),
      createModelInterceptor,
      false,
    );

    /// Send the request.
    final response = await getIt<HttpClient>().upload<T>(
      url: url,
      fileKey: fileKey,
      filePath: filePath,
      fileName: filePath.substring(filePath.lastIndexOf('/') + 1),
      mediaType: mediaType,
      data: data,
      headers: headers,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
      responseValidator: responseValidator ?? DefaultResponseValidator(),
      baseUrl: baseUrl,
      requiresAuth:
          withAuthentication, // Pass authentication requirement to HTTP client
      enableLogging: enableLogging, // Pass logging control to HTTP client
    );

    /// convert jsonResponse to model and return it
    if (response.isLeft()) {
      return Left((response as Left<AppErrors, T>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<AppErrors, T>).value;
        return Right(resValue);
      } catch (e) {
        e.toString().logE;
        return const Left(
            CustomError(message: "Catch error in remote data source"));
      }
    } else {
      return const Left(UnknownError());
    }
  }

  Future<Either<AppErrors, T>> request<T extends BaseModel>({
    required T Function(dynamic json) converter,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    bool withAuthentication = false,
    CancelToken? cancelToken,
    ResponseValidator? responseValidator,
    Map<String, String>? headers,
    String? baseUrl,
    bool isFormData = true,
    CreateModelInterceptor createModelInterceptor =
        const DefaultCreateModelInterceptor(),
    bool enableLogging = false, // Add parameter to control per-method logging
    BaseParams? params, // ✅ NEW: Accept params for automatic cache control
  }) async {
    // Register the response.
    ModelsFactory().registerModel(
      T.toString(),
      converter,
      createModelInterceptor.toString(),
      createModelInterceptor,
      false,
    );

    /// Send the request.
    final response = await getIt<HttpClient>().sendRequest<T>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters ?? {},
      body: body,
      cancelToken: cancelToken,
      responseValidator: responseValidator ?? DefaultResponseValidator(),
      baseUrl: baseUrl,
      isFormData: isFormData,
      requiresAuth:
          withAuthentication, // Pass authentication requirement to HTTP client
      enableLogging: enableLogging, // Pass logging control to HTTP client
    );

    /// convert jsonResponse to model and return it
    if (response.isLeft()) {
      return Left((response as Left<AppErrors, T>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<AppErrors, T>).value;

        // ✅ 3. Save to cache if successful and caching is enabled
        if (params != null && params.isCacheEnabled) {
          try {
            final cacheService = getIt<GenericCacheService>();
            final cacheKey = params.cacheKey;

            print('💾 Saving to cache: $cacheKey');

            await cacheService.put(
              feature: params.cacheFeature,
              key: cacheKey,
              data: (resValue as dynamic).toJson() as Map<String, dynamic>,
            );
          } catch (e) {
            print('⚠️ Error saving to cache (non-fatal): $e');
            // Don't fail the request if caching fails
          }
        }

        // ✅ 4. Handle cache invalidation for mutations
        if (params != null) {
          await _handleCacheInvalidation(params);
        }

        return Right(resValue);
      } catch (e) {
        e.toString().logE;
        return const Left(
            CustomError(message: "Catch error in remote data source"));
      }
    } else {
      return const Left(UnknownError());
    }
  }

  Future<Either<AppErrors, List<T>>> listRequest<T extends BaseModel>({
    required T Function(dynamic json) converter,
    required HttpMethod method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    bool withAuthentication = false,
    CancelToken? cancelToken,
    ResponseValidator? responseValidator,
    Map<String, String>? headers,
    String? baseUrl,
    CreateModelInterceptor createModelInterceptor =
        const PrimitiveCreateModelInterceptor(),
    String key = "data",
    bool enableLogging = false, // Add parameter to control per-method logging
    BaseParams? params, // ✅ NEW: Accept params for automatic cache control
  }) async {
    // ✅ 1. Check cache if params indicate caching is enabled (skip if forceRefresh)
    if (params != null && params.isCacheEnabled && !params.shouldBypassCache) {
      try {
        final cacheService = getIt<GenericCacheService>();
        final cacheKey = params.cacheKey;

        print(
            '🔍 Checking list cache for: $cacheKey (feature: ${params.cacheFeature})');

        final cached = await cacheService.getList<T>(
          feature: params.cacheFeature,
          key: cacheKey,
          fromJson: (json) => converter(json),
          ttl: params.cacheTTL,
        );

        if (cached != null && cached.isNotEmpty) {
          print('⚡ List cache HIT: $cacheKey (${cached.length} items)');
          return Right(cached);
        }

        print('❌ List cache MISS: $cacheKey');
      } catch (e) {
        print('⚠️ Cache error (continuing with API call): $e');
        // Continue with API call if cache fails
      }
    } else if (params != null && params.shouldBypassCache) {
      print('🔄 Force refresh: Bypassing cache for ${params.cacheFeature}');
    }
    // Register the response.
    ModelsFactory().registerModel(
      T.toString(),
      converter,
      createModelInterceptor.toString(),
      createModelInterceptor,
      true,
    );

    /// Send the request.
    final response = await getIt<HttpClient>().sendListRequest<T>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters ?? {},
      body: body,
      cancelToken: cancelToken,
      responseValidator: responseValidator ?? ListResponseValidator(),
      baseUrl: baseUrl,
      key: key,
      requiresAuth:
          withAuthentication, // Pass authentication requirement to HTTP client
      enableLogging: enableLogging, // Pass logging control to HTTP client
    );

    /// convert jsonResponse to model and return it
    if (response.isLeft()) {
      return Left((response as Left<AppErrors, List<T>>).value);
    } else if (response.isRight()) {
      try {
        final resValue = (response as Right<AppErrors, List<T>>).value;

        // ✅ 3. Save list to cache if successful and caching is enabled
        if (params != null && params.isCacheEnabled) {
          try {
            final cacheService = getIt<GenericCacheService>();
            final cacheKey = params.cacheKey;

            print(
                '💾 Saving list to cache: $cacheKey (${resValue.length} items)');

            final jsonList = resValue
                .map((item) =>
                    (item as dynamic).toJson() as Map<String, dynamic>)
                .toList();

            await cacheService.putList(
              feature: params.cacheFeature,
              key: cacheKey,
              items: jsonList,
            );
          } catch (e) {
            print('⚠️ Error saving list to cache (non-fatal): $e');
            // Don't fail the request if caching fails
          }
        }

        // ✅ 4. Handle cache invalidation for mutations (for list requests too)
        if (params != null) {
          await _handleCacheInvalidation(params);
        }

        return Right(resValue);
      } catch (e) {
        e.toString().logE;
        return const Left(
            CustomError(message: "Catch error in remote data source"));
      }
    } else {
      return const Left(UnknownError());
    }
  }

  /// Handle cache invalidation after successful mutations
  /// Clears caches specified in param's invalidateCaches list
  /// Auto-clears own feature cache if isMutation = true
  Future<void> _handleCacheInvalidation(BaseParams params) async {
    try {
      // Skip if not a mutation and no explicit invalidation
      if (!params.isMutation && params.invalidateCaches == null) {
        return;
      }

      final cacheService = getIt<GenericCacheService>();

      // Invalidate explicitly specified caches (cross-feature invalidation)
      if (params.invalidateCaches != null &&
          params.invalidateCaches!.isNotEmpty) {
        for (final feature in params.invalidateCaches!) {
          await cacheService.clear(feature);
          print('🗑️ Cache invalidated for feature: $feature');
        }
      }

      // Auto-invalidate own feature if mutation (unless already invalidated above)
      if (params.isMutation &&
          !(params.invalidateCaches?.contains(params.cacheFeature) ?? false)) {
        await cacheService.clear(params.cacheFeature);
        print('🗑️ Auto-invalidated cache for feature: ${params.cacheFeature}');
      }
    } catch (e) {
      print('⚠️ Error invalidating cache (non-fatal): $e');
      // Don't fail the request if cache invalidation fails
    }
  }
}
