import 'package:scouting_app/core/common/type_validators.dart';
import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/data/request/model/user_info_model.dart';
import 'package:scouting_app/feature/account/domain/entity/aff_payment_entity.dart';

class AffPaymentModel extends BaseModel<AffPaymentEntity> {
  final String id;
  final String userId;
  final String amount;
  final String fullAmount;
  final String status;
  final String time;
  final UserInfoModel user;
  final String totalRefs;
  final String timeText;
  AffPaymentModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.fullAmount,
    required this.status,
    required this.time,
    required this.user,
    required this.totalRefs,
    required this.timeText,
  });
  factory AffPaymentModel.fromMap(Map<String, dynamic> map) {
    return AffPaymentModel(
      id: stringV(map['id']),
      userId: stringV(map['user_id']),
      amount: stringV(map['amount']),
      fullAmount: stringV(map['full_amount']),
      status: stringV(map['status']),
      time: stringV(map['time']),
      user: UserInfoModel.fromMap(map['user'] as Map<String, dynamic>),
      totalRefs: stringV(map['total_refs']),
      timeText: stringV(map['time_text']),
    );
  }

  @override
  AffPaymentEntity toEntity() {
    return AffPaymentEntity(
      id: id,
      userId: userId,
      amount: amount,
      fullAmount: fullAmount,
      status: status,
      time: time,
      user: user.toEntity(),
      totalRefs: totalRefs,
      timeText: timeText,
    );
  }
}
