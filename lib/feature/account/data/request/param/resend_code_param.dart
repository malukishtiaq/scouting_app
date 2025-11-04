import 'package:scouting_app/core/common/extensions/string_extensions.dart';
import 'package:scouting_app/core/params/base_params.dart';

class ResendCodeParam extends BaseParams {
  final String? mobileNumber;
  final String? email;
  final String? countryCode;

  ResendCodeParam({
    required this.mobileNumber,
    this.email = "",
    this.countryCode = "",
  });

  @override
  Map<String, dynamic> toMap() => {
        if (mobileNumber.isNotEmptyNorNull) "PhoneNo": mobileNumber,
        if (mobileNumber.isNotEmptyNorNull) "PhoneNoFull": mobileNumber,

        ///this is different from the above because their is difference in api.
        if (email.isNotEmptyNorNull) "Email": email,
        if (countryCode.isNotEmptyNorNull) "PhoneCountryCode": countryCode,
      };
}
