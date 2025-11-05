import '../../../../../core/params/base_params.dart';

/// Parameter for updating user profile
/// POST /api/profile (multipart/form-data)
class UpdateProfileParam extends BaseParams {
  final String? name;
  final int? age;
  final double? weight;
  final double? height;
  final String? primaryPosition;
  final String? preferredFoot;
  final String? avatarPath; // Path to avatar file for upload

  UpdateProfileParam({
    this.name,
    this.age,
    this.weight,
    this.height,
    this.primaryPosition,
    this.preferredFoot,
    this.avatarPath,
    super.cancelToken,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      if (name != null) 'name': name,
      if (age != null) 'age': age,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (primaryPosition != null) 'primary_position': primaryPosition,
      if (preferredFoot != null) 'preferred_foot': preferredFoot,
      // Note: avatar file is handled separately in remote datasource
    };
  }

  @override
  bool get isMutation => true; // Updating profile is a mutation

  @override
  List<String>? get invalidateCaches => ['profile']; // Invalidate profile cache

  @override
  String? get featureName => 'profile'; // Use profile cache feature
}

