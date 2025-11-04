import 'package:scouting_app/export_files.dart';

enum AppContentType {
  terms("terms_and_conditions"),
  privacyPolicy("privacy_policy"),
  cancellation("cancellation_policy"),
  bookingTerms("booking_terms"),
  aboutUs("about_us");

  final String mapToString;

  const AppContentType(this.mapToString);

  String get name => "termsAndConditions".tr;
  //S.of(AppConfig().appContext!).termsAndConditions;
  //switch (this) {
  //       (AppContentType t) when t == terms =>
  //         S.of(AppConfig().appContext!).termsAndConditions,
  //       (AppContentType t) when t == privacyPolicy =>
  //         S.of(AppConfig().appContext!).privacyPolicyAndCookies,
  //       (AppContentType t) when t == cancellation =>
  //         S.of(AppConfig().appContext!).cancellationAndRefund,
  //       (AppContentType t) when t == aboutUs =>
  //         S.of(AppConfig().appContext!).aboutUs,
  //       (_) => "",
  //     };
}
