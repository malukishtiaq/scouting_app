import 'package:scouting_app/feature/account/data/request/param/social_base.dart';

class SocialAppleLoginParam extends SocialBase {
  final String socialAppleId;

  SocialAppleLoginParam({
    required this.socialAppleId,
    required super.email,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Email": email,
        "SocialAppleId": socialAppleId,
      };
}
