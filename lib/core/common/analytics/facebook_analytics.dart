//import 'package:facebook_app_events/facebook_app_events.dart';

import 'app_analytics.dart';

class FacebookAnalytics extends AnalyticsInterface {
  // final _analytics = FacebookAppEvents();

  @override
  Future<void> initialize() async {
    // await Future.wait([
    //   _analytics.setAdvertiserTracking(enabled: true),
    //   _analytics.setAutoLogAppEventsEnabled(true),
    // ]);
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
