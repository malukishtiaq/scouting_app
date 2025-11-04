// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/entities/base_entity.dart';
import 'user_info_object.dart';

import '../../../../core/common/type_validators.dart';

class LikeEntity extends BaseEntity {
  final int id;
  final int likeUserid;
  final int isLike;
  final int isDislike;
  UserInfoEntity data;
  LikeEntity({
    required this.id,
    required this.likeUserid,
    required this.isLike,
    required this.isDislike,
    required this.data,
  });

  @override
  List<Object?> get props => [id, likeUserid, isLike, isDislike, data];

  LikeEntity copyWith({
    int? id,
    int? likeUserid,
    int? isLike,
    int? isDislike,
    UserInfoEntity? data,
  }) {
    return LikeEntity(
      id: id ?? this.id,
      likeUserid: likeUserid ?? this.likeUserid,
      isLike: isLike ?? this.isLike,
      isDislike: isDislike ?? this.isDislike,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': numV(id),
      'likeUserid': numV(likeUserid),
      'isLike': numV(isLike),
      'isDislike': numV(isDislike),
      'data': data.toMap(),
    };
  }

  factory LikeEntity.fromMap(Map<String, dynamic> map) {
    return LikeEntity(
      id: numV(map['id']) ?? 0,
      likeUserid: numV(map['likeUserid']) ?? 0,
      isLike: numV(map['isLike']) ?? 0,
      isDislike: numV(map['isDislike']) ?? 0,
      data: UserInfoEntity.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeEntity.fromJson(String source) =>
      LikeEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
