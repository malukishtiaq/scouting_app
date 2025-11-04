import '../../../../../core/params/base_params.dart';

class VerifyOtpParam extends BaseParams {
  final String code;
  final String phoneNoFull;
  final String email;

  VerifyOtpParam({
    required this.code,
    required this.phoneNoFull,
    required this.email,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Otp": code,
        "PhoneNoFull": phoneNoFull,
        "Email": email,
      };
}
