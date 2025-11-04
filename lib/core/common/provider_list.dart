import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../di/service_locator.dart';
import '../localization/localization_provider.dart';
import '../providers/session_data.dart';
import '../services/notification_service.dart';

/// Centralizing all app providers in one class to be easy to adjust and read
class ApplicationProvider {
  static final ApplicationProvider _instance = ApplicationProvider._init();

  factory ApplicationProvider() => _instance;

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];

  List<SingleChildWidget> dependItems = [
    /// Change notifier provider

    ChangeNotifierProvider.value(value: getIt<SessionData>()),

    Provider.value(value: getIt<NotificationService>()),

    // ChangeNotifierProvider.value(value: getIt<MessageServiceProvider>()),
  ];

  List<SingleChildWidget> uiChangesItems = [];

  void dispose(BuildContext context) {
    debugPrint("Disposed app providers");
    Provider.of<LocalizationProvider>(context, listen: false).dispose();
    getIt<SessionData>().dispose();
  }
}
