import '../../../../../core/models/base_model.dart';
import '../../../domain/entities/update_settings_response_entity.dart';

class UpdateSettingsResponseModel
    extends BaseModel<UpdateSettingsResponseEntity> {
  final int apiStatus;
  final String? message;
  final String? data;

  UpdateSettingsResponseModel({
    required this.apiStatus,
    this.message,
    this.data,
  });

  factory UpdateSettingsResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateSettingsResponseModel(
      apiStatus: json["api_status"] ?? 400,
      message: json["message"],
      data: json["data"],
    );
  }

  @override
  UpdateSettingsResponseEntity toEntity() {
    return UpdateSettingsResponseEntity(
      apiStatus: apiStatus,
      message: message,
      data: data,
    );
  }
}
