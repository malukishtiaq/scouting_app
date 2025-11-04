import 'base_entity.dart';

class EmptyResponseEntity extends BaseEntity {
  final bool? succeed;
  final String? message;
  final String? status;
  final dynamic data;
  final int? code;
  final Map<String, dynamic>? errors;

  EmptyResponseEntity({
    this.succeed,
    this.message,
    this.status,
    this.data,
    this.code,
    this.errors,
  });

  @override
  List<Object?> get props => [
        succeed,
        message,
        status,
        data,
        code,
        errors,
      ];

  bool get isSuccess => succeed == true;
  bool get isError => succeed == false;
  String get displayMessage => message ?? 'No message';
}
