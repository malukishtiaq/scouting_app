// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/entities/base_entity.dart';
import 'user_info_object.dart';

import '../../../../core/common/type_validators.dart';

class BlockEntity extends BaseEntity {
  final int id;
  final int blockUserid;
  final String createdAt;
  final UserInfoEntity data;
  BlockEntity({
    required this.id,
    required this.blockUserid,
    required this.createdAt,
    required this.data,
  });

  @override
  List<Object?> get props => [id, blockUserid, createdAt, data];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': numV(id),
      'blockUserid': numV(blockUserid),
      'createdAt': stringV(createdAt),
      'data': data.toMap(),
    };
  }

  factory BlockEntity.fromMap(Map<String, dynamic> map) {
    return BlockEntity(
      id: numV(map['id']) ?? 0,
      blockUserid: numV(map['blockUserid']) ?? 0,
      createdAt: stringV(map['createdAt']),
      data: UserInfoEntity.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockEntity.fromJson(String source) =>
      BlockEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
