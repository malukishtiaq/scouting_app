import 'package:scouting_app/export_files.dart';
import 'package:scouting_app/core/constants/app/app_constants.dart';

enum Gender {
  MALE('male'),
  FEMALE('female');

  final String mapToString;

  const Gender(this.mapToString);

  String get icon {
    switch (this) {
      case Gender.MALE:
        return AppConstants.MALE_ICON;
      case Gender.FEMALE:
        return AppConstants.FEMALE_ICON;
    }
  }

  String get name {
    switch (this) {
      case Gender.MALE:
        return "male".tr;
      case Gender.FEMALE:
        return "female".tr;
    }
  }
}

Gender? genderFromString(String? value) {
  return Gender.MALE;
  // return switch (value) {
  //   (String v) when v == 'male' => Gender.MALE,
  //   (String v) when v == 'female' => Gender.FEMALE,
  //   (_) => null,
  // };
}
