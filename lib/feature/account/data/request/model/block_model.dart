import 'package:scouting_app/core/common/type_validators.dart';
import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/data/request/model/user_info_model.dart';
import 'package:scouting_app/feature/account/domain/entity/block_entity.dart';

class BlockModel extends BaseModel<BlockEntity> {
  final int id;
  final int blockUserid;
  final String createdAt;
  final UserInfoModel data;
  BlockModel({
    required this.id,
    required this.blockUserid,
    required this.createdAt,
    required this.data,
  });

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(
      id: numV(map['id']) ?? 0,
      blockUserid: numV(map['block_userid']) ?? 0,
      createdAt: stringV(map['created_at']),
      data: UserInfoModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  @override
  BlockEntity toEntity() {
    return BlockEntity(
      id: id,
      blockUserid: blockUserid,
      createdAt: createdAt,
      data: data.toEntity(),
    );
  }
}
