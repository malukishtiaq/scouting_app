// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/entities/base_entity.dart';
import 'user_info_object.dart';

import '../../../../core/common/type_validators.dart';

class PaymentEntity extends BaseEntity {
  final int id;
  final int amount;
  final String type;
  final String date;
  final String via;
  final String proPlan;
  final String creditAmount;
  PaymentEntity({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.via,
    required this.proPlan,
    required this.creditAmount,
  });

  @override
  List<Object?> get props =>
      [id, amount, type, date, via, proPlan, creditAmount];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': numV(id),
      'amount': numV(amount),
      'type': stringV(type),
      'date': stringV(date),
      'via': stringV(via),
      'proPlan': stringV(proPlan),
      'creditAmount': stringV(creditAmount),
    };
  }

  factory PaymentEntity.fromMap(Map<String, dynamic> map) {
    return PaymentEntity(
      id: numV(map['id']) ?? 0,
      amount: numV(map['amount']) ?? 0,
      type: stringV(map['type']),
      date: stringV(map['date']),
      via: stringV(map['via']),
      proPlan: stringV(map['proPlan']),
      creditAmount: stringV(map['creditAmount']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentEntity.fromJson(String source) =>
      PaymentEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
