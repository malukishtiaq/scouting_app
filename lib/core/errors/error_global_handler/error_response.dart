class ErrorResponse {
  final String? message;
  final String? stackTrace;
  final int? httpError;
  final Map<String, dynamic>? data;

  ErrorResponse({
    this.message,
    this.stackTrace,
    this.httpError,
    this.data,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(
      message: json['message'],
      stackTrace: json['stackTrace'],
      httpError: json['httpError'],
      data: json['data'],
    );
  }
}
