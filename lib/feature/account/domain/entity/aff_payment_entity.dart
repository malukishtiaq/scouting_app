// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/entities/base_entity.dart';
import 'user_info_object.dart';

import '../../../../core/common/type_validators.dart';

class AffPaymentEntity extends BaseEntity {
  final String id;
  final String userId;
  final String amount;
  final String fullAmount;
  final String status;
  final String time;
  final UserInfoEntity user;
  final String totalRefs;
  final String timeText;
  AffPaymentEntity({
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

  @override
  List<Object?> get props => [
        id,
        userId,
        amount,
        fullAmount,
        status,
        time,
        user,
        totalRefs,
        timeText,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': stringV(id),
      'userId': stringV(userId),
      'amount': stringV(amount),
      'fullAmount': stringV(fullAmount),
      'status': stringV(status),
      'time': stringV(time),
      'user': user.toMap(),
      'totalRefs': stringV(totalRefs),
      'timeText': stringV(timeText),
    };
  }

  factory AffPaymentEntity.fromMap(Map<String, dynamic> map) {
    return AffPaymentEntity(
      id: stringV(map['id']),
      userId: stringV(map['userId']),
      amount: stringV(map['amount']),
      fullAmount: stringV(map['fullAmount']),
      status: stringV(map['status']),
      time: stringV(map['time']),
      totalRefs: stringV(map['totalRefs']),
      timeText: stringV(map['timeText']),
      user: UserInfoEntity.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AffPaymentEntity.fromJson(String source) =>
      AffPaymentEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
