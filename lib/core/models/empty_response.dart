import '../../core/entities/empty_response_entity.dart';
import '../common/type_validators.dart';
import 'base_model.dart';

class EmptyResponse extends BaseModel<EmptyResponseEntity> {
  final bool? succeed;
  final String? message;
  final String? status;
  final dynamic data;
  final int? code;
  final Map<String, dynamic>? errors;

  EmptyResponse({
    this.succeed,
    this.message,
    this.status,
    this.data,
    this.code,
    this.errors,
  });

  factory EmptyResponse.fromMap(dynamic json) {
    // Handle case where response is a simple string
    if (json is String) {
      return EmptyResponse(
        message: json,
        succeed: true,
        status: "success",
      );
    }

    // Handle case where response is a Map
    if (json is Map) {
      return EmptyResponse(
        succeed: json["succeed"] != null ? boolV(json["succeed"]) : null,
        message: json["message"] != null ? stringV(json["message"]) : null,
        status: json["status"] != null ? stringV(json["status"]) : null,
        data: json["data"],
        code: json["code"] != null ? numV(json["code"]) : null,
        errors: json["errors"] is Map<String, dynamic>
            ? json["errors"] as Map<String, dynamic>
            : null,
      );
    }

    // Handle case where response is null or other types
    return EmptyResponse(
      message: "Unknown response format",
      succeed: false,
      status: "error",
    );
  }

  Map<String, dynamic> toMap() => {
        "succeed": succeed,
        "message": message,
        "status": status,
        "data": data,
        "code": code,
        "errors": errors,
      };

  @override
  EmptyResponseEntity toEntity() {
    return EmptyResponseEntity(
      succeed: succeed,
      message: message,
      status: status,
      data: data,
      code: code,
      errors: errors,
    );
  }
}
