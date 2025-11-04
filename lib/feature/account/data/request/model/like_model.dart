import 'package:scouting_app/core/common/type_validators.dart';
import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/data/request/model/user_info_model.dart';
import 'package:scouting_app/feature/account/domain/entity/like_entity.dart';

class LikeModel extends BaseModel<LikeEntity> {
  final int id;
  final int likeUserid;
  final int isLike;
  final int isDislike;
  UserInfoModel data;
  LikeModel({
    required this.id,
    required this.likeUserid,
    required this.isLike,
    required this.isDislike,
    required this.data,
  });

  factory LikeModel.fromMap(Map<String, dynamic> map) {
    return LikeModel(
      id: numV(map['id']) ?? 0,
      likeUserid: numV(map['like_userid']) ?? 0,
      isLike: numV(map['is_like']) ?? 0,
      isDislike: numV(map['is_dislike']) ?? 0,
      data: UserInfoModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  @override
  LikeEntity toEntity() {
    return LikeEntity(
      id: id,
      likeUserid: likeUserid,
      isLike: isLike,
      isDislike: isDislike,
      data: data.toEntity(),
    );
  }
}
