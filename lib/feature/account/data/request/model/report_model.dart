import 'package:scouting_app/core/common/type_validators.dart';
import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/data/request/model/user_info_model.dart';
import 'package:scouting_app/feature/account/domain/entity/report_entity.dart';

class ReportModel extends BaseModel<ReportEntity> {
  final int id;
  final int reportUserid;
  final String createdAt;
  UserInfoModel data;
  ReportModel({
    required this.id,
    required this.reportUserid,
    required this.createdAt,
    required this.data,
  });

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: numV(map['id']) ?? 0,
      reportUserid: numV(map['report_userid']) ?? 0,
      createdAt: stringV(map['created_at']),
      data: UserInfoModel.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  @override
  ReportEntity toEntity() {
    return ReportEntity(
      id: id,
      reportUserid: reportUserid,
      createdAt: createdAt,
      data: data.toEntity(),
    );
  }
}
