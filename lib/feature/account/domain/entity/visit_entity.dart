// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/common/type_validators.dart';
import '../../../../core/entities/base_entity.dart';
import 'user_info_object.dart';

class VisitEntity extends BaseEntity {
  final int id;
  final int viewUserid;
  final String createdAt;
  final UserInfoEntity data;
  VisitEntity({
    required this.id,
    required this.viewUserid,
    required this.createdAt,
    required this.data,
  });

  @override
  List<Object?> get props => [id, viewUserid, createdAt, data];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': numV(id),
      'viewUserid': numV(viewUserid),
      'createdAt': stringV(createdAt),
      'data': data.toMap(),
    };
  }

  factory VisitEntity.fromMap(Map<String, dynamic> map) {
    return VisitEntity(
      id: numV(map['id']) ?? 0,
      viewUserid: numV(map['viewUserid']) ?? 0,
      createdAt: stringV(map['createdAt']),
      data: UserInfoEntity.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitEntity.fromJson(String source) =>
      VisitEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
