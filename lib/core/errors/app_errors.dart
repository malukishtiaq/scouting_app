import 'package:freezed_annotation/freezed_annotation.dart';

import '../constants/enums/error_code_type.dart';
import 'http_error.dart';

part 'app_errors.freezed.dart';

@freezed
class AppErrors with _$AppErrors {
  @Implements<HttpError>()
  const factory AppErrors.connectionError({
    String? message,
  }) = ConnectionError;

  @Implements<HttpError>()
  const factory AppErrors.internalServerError({
    String? message,
  }) = InternalServerError;

  @Implements<HttpError>()
  const factory AppErrors.internalServerWithDataError(
    int errorCode, {
    String? message,
    required ErrorCodeType type,
  }) = InternalServerWithDataError;

  const factory AppErrors.accountNotVerifiedError({
    String? message,
  }) = AccountNotVerifiedError;

  /// BadRequestError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.badRequestError({
    @Default("") String message,
    @Default({}) Map<String, dynamic> errors,
  }) = BadRequestError;

  /// CancelError extends BaseError
  const factory AppErrors.cancelError(String? message) = CancelError;

  /// ConflictError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.conflictError({
    String? message,
  }) = ConflictError;

  /// CustomError extends BaseError
  const factory AppErrors.customError({
    @Default("") String message,
    @Default({}) Map<String, dynamic> errors,
  }) = CustomError;

  /// ForbiddenError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.forbiddenError({
    String? message,
  }) = ForbiddenError;

  /// FormatError extends BaseError
  const factory AppErrors.formatError({
    String? message,
  }) = FormatError;

  /// LoginRequiredError extends BaseError
  const factory AppErrors.loginRequiredError({
    String? message,
  }) = LoginRequiredError;

  /// NetError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.netError({
    String? message,
  }) = NetError;

  /// NotFoundError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.notFoundError(
    String requestedUrlPath, {
    String? message,
  }) = NotFoundError;

  /// ResponseError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.responseError({
    String? message,
  }) = ResponseError;

  /// ScreenNotImplementedError extends BaseError
  const factory AppErrors.screenNotImplementedError({
    String? message,
  }) = ScreenNotImplementedError;

  /// SocketError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.socketError({
    String? message,
  }) = SocketError;

  /// TimeoutError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.timeoutError({
    String? message,
  }) = TimeoutError;

  /// UnauthorizedError extends HttpError
  @Implements<HttpError>()
  const factory AppErrors.unauthorizedError({
    String? message,
  }) = UnauthorizedError;

  /// UnknownError extends ConnectionError
  @Implements<HttpError>()
  const factory AppErrors.unknownError({
    String? message,
  }) = UnknownError;
}
