import 'package:scouting_app/core/common/analytics/google_analytics.dart';

import 'facebook_analytics.dart';

abstract class AnalyticsInterface {
  Future<void> initialize();
  Future<void> logRegister();
  Future<void> logLogin();
  Future<void> logAddToCart(dynamic item);
  Future<void> logSearch();
  Future<void> logPageView();
  Future<void> logInitCheckout();
  Future<void> logPaymentFailed();
  Future<void> logPurchase();
}

class AppAnalytics extends AnalyticsInterface {
  static final _instance = AppAnalytics._();
  factory AppAnalytics() => _instance;
  AppAnalytics._();

  final _googleAnalytics = GoogleAnalytics();
  final _facebookAnalytics = FacebookAnalytics();

  @override
  Future<void> initialize() async {
    await Future.wait([
      _googleAnalytics.initialize(),
      _facebookAnalytics.initialize(),
    ]);
  }

  @override
  Future<void> logAddToCart(item) async {
    await Future.wait([
      _googleAnalytics.logAddToCart(item),
      _facebookAnalytics.logAddToCart(item),
    ]);
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
