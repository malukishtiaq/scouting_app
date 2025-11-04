import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/data/request/model/user_info_model.dart';
import 'package:scouting_app/feature/account/domain/entity/visit_entity.dart';

class VisitModel extends BaseModel<VisitEntity> {
  final int id;
  final int viewUserid;
  final String createdAt;
  final UserInfoModel data;
  VisitModel({
    required this.id,
    required this.viewUserid,
    required this.createdAt,
    required this.data,
  });

  factory VisitModel.fromMap(Map<String, dynamic> map) {
    return VisitModel(
      id: map['id'] as int,
      viewUserid: map['view_userid'] as int,
      createdAt: map['created_at'] as String,
      data: UserInfoModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  @override
  VisitEntity toEntity() {
    return VisitEntity(
      id: id,
      viewUserid: viewUserid,
      createdAt: createdAt,
      data: data.toEntity(),
    );
  }
}
