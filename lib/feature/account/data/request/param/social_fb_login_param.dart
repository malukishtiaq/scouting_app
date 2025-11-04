import 'social_base.dart';

class SocialFBLoginParam extends SocialBase {
  final String socialFBId;

  SocialFBLoginParam({
    required super.email,
    required this.socialFBId,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Email": email,
        "SocialFacebookId": socialFBId,
      };
}
