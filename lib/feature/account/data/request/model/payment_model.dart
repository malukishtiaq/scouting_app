import 'package:scouting_app/core/common/type_validators.dart';
import 'package:scouting_app/core/models/base_model.dart';
import 'package:scouting_app/feature/account/domain/entity/payment_entity.dart';

class PaymentModel extends BaseModel<PaymentEntity> {
  final int id;
  final int amount;
  final String type;
  final String date;
  final String via;
  final String proPlan;
  final String creditAmount;
  PaymentModel({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.via,
    required this.proPlan,
    required this.creditAmount,
  });

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: numV(map['id']) ?? 0,
      amount: numV(map['amount']) ?? 0,
      type: stringV(map['type']),
      date: stringV(map['date']),
      via: stringV(map['via']),
      proPlan: stringV(map['pro_plan']),
      creditAmount: stringV(map['credit_amount']),
    );
  }

  @override
  PaymentEntity toEntity() {
    return PaymentEntity(
      id: id,
      amount: amount,
      type: type,
      date: date,
      via: via,
      proPlan: proPlan,
      creditAmount: creditAmount,
    );
  }
}
