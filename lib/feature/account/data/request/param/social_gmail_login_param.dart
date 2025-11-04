import 'package:scouting_app/feature/account/data/request/param/social_base.dart';

class SocialGmailLoginParam extends SocialBase {
  final String socialGmailId;

  SocialGmailLoginParam({
    required this.socialGmailId,
    required super.email,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Email": email,
        "SocialGmailId": socialGmailId,
      };
}
