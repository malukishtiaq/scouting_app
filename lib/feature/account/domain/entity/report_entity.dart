// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/entities/base_entity.dart';
import 'user_info_object.dart';
import '../../../../core/common/type_validators.dart';

class ReportEntity extends BaseEntity {
  final int id;
  final int reportUserid;
  final String createdAt;
  UserInfoEntity data;
  ReportEntity({
    required this.id,
    required this.reportUserid,
    required this.createdAt,
    required this.data,
  });

  @override
  List<Object?> get props => [id, reportUserid, createdAt, data];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': numV(id),
      'reportUserid': numV(reportUserid),
      'createdAt': stringV(createdAt),
      'data': data.toMap(),
    };
  }

  factory ReportEntity.fromMap(Map<String, dynamic> map) {
    return ReportEntity(
      id: numV(map['id']) ?? 0,
      reportUserid: numV(map['reportUserid']) ?? 0,
      createdAt: stringV(map['createdAt']),
      data: UserInfoEntity.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportEntity.fromJson(String source) =>
      ReportEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
