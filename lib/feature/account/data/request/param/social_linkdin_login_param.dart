import 'social_base.dart';

class SocialLinkedInLoginParam extends SocialBase {
  final String socialLinkedInId;

  SocialLinkedInLoginParam({
    required super.email,
    required this.socialLinkedInId,
  });

  @override
  Map<String, dynamic> toMap() => {
        "Email": email,
        "SocialLinkedInId": socialLinkedInId,
      };
}
