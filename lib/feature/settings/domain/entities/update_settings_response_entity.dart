import '../../../../core/entities/base_entity.dart';

class UpdateSettingsResponseEntity extends BaseEntity {
  final int apiStatus;
  final String? message;
  final String? data;

  UpdateSettingsResponseEntity({
    required this.apiStatus,
    this.message,
    this.data,
  });

  @override
  List<Object?> get props => [apiStatus, message, data];
}
