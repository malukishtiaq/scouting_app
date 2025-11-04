// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../../core/params/base_params.dart';

class ResgisterParam extends BaseParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNo;
  final String phoneCountryCode;
  final String password;
  final String socialFacebookId;
  final String socialFacebookToken;
  final String socialLinkedInId;
  final String socialLinkedInToken;
  final String socialGmailId;
  final String socialAppleId;
  final String country;

  ResgisterParam({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNo,
    required this.phoneCountryCode,
    required this.country,
    required this.password,
    required this.socialAppleId,
    required this.socialFacebookId,
    required this.socialFacebookToken,
    required this.socialGmailId,
    required this.socialLinkedInId,
    required this.socialLinkedInToken,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Email": email,
        "FirstName": firstName,
        "LastName": lastName,
        "Password": password,
        "SocialFacebookId": socialFacebookId,
        "SocialFacebookToken": socialFacebookToken,
        "SocialLinkedIn": socialLinkedInId,
        "SocialLinkedInToken": socialLinkedInToken,
        "SocialGmailId": socialGmailId,
        "SocialAppleId": socialAppleId,
        "CountryCode": phoneCountryCode,
        "Country": country,
        "PhoneNo": phoneNo,
      };

  ResgisterParam copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNo,
    String? phoneCountryCode,
    String? password,
    String? socialFacebookId,
    String? socialFacebookToken,
    String? socialLinkedInId,
    String? socialLinkedInToken,
    String? socialGmailId,
    String? socialAppleId,
    String? country,
  }) {
    return ResgisterParam(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      phoneCountryCode: phoneCountryCode ?? this.phoneCountryCode,
      password: password ?? this.password,
      socialFacebookId: socialFacebookId ?? this.socialFacebookId,
      socialFacebookToken: socialFacebookToken ?? this.socialFacebookToken,
      socialLinkedInId: socialLinkedInId ?? this.socialLinkedInId,
      socialLinkedInToken: socialLinkedInToken ?? this.socialLinkedInToken,
      socialGmailId: socialGmailId ?? this.socialGmailId,
      socialAppleId: socialAppleId ?? this.socialAppleId,
      country: country ?? this.country,
    );
  }
}
