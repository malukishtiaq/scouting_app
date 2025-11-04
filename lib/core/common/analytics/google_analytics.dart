import 'package:scouting_app/core/common/analytics/app_analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class GoogleAnalytics extends AnalyticsInterface {
  final _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> initialize() async {
    await Future.wait([
      _analytics.setAnalyticsCollectionEnabled(true),
      _analytics.app.setAutomaticDataCollectionEnabled(true),
      _analytics.app.setAutomaticResourceManagementEnabled(true),
      _analytics.logAppOpen(),
    ]);
  }

  @override
  Future<void> logAddToCart(item) async {
    // TODO: implement logLogin
    throw UnimplementedError();
  }

  @override
  Future<void> logInitCheckout() {
    // TODO: implement logInitCheckout
    throw UnimplementedError();
  }

  @override
  Future<void> logLogin() {
    // TODO: implement logLogin
    throw UnimplementedError();
  }

  @override
  Future<void> logPageView() {
    // TODO: implement logPageView
    throw UnimplementedError();
  }

  @override
  Future<void> logPaymentFailed() {
    // TODO: implement logPaymentFailed
    throw UnimplementedError();
  }

  @override
  Future<void> logPurchase() {
    // TODO: implement logPurchase
    throw UnimplementedError();
  }

  @override
  Future<void> logRegister() {
    // TODO: implement logRegister
    throw UnimplementedError();
  }

  @override
  Future<void> logSearch() {
    // TODO: implement logSearch
    throw UnimplementedError();
  }
}
