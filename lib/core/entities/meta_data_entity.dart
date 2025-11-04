import 'package:scouting_app/core/entities/base_entity.dart';

class MetaDataEntity extends BaseEntity {
  final int? total;

  MetaDataEntity({
    required this.total,
  });

  @override
  List<Object?> get props => [total];
}
