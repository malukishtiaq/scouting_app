import 'package:flutter/material.dart';

import 'package:scouting_app/feature/splash/presentation/screen/splash_screen.dart';
import 'package:scouting_app/di/service_locator.dart';
import 'package:scouting_app/core/navigation/route_generator.dart';
import 'package:scouting_app/core/navigation/navigation_service.dart';
import 'package:scouting_app/core/common/utils/size_utils.dart';
import 'package:scouting_app/localization/app_localization.dart';
import 'package:scouting_app/core/services/notification_service.dart';
import 'package:scouting_app/core/services/background_chat_service.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    print('🔗 MainApp: initState() called');

    try {
      // Set the navigation key in the NavigationService
      print('🔗 MainApp: Setting navigation key...');
      getIt<NavigationService>().setNavigationKey(_navigatorKey);

      // DeepLinkHandler already initialized in main.dart - no need to initialize again
      print('🔗 MainApp: DeepLinkHandler already initialized in main.dart');

      // Initialize notification services (hybrid approach like Xamarin)
      _initializeNotificationServices();
    } catch (e) {
      print('🔗 MainApp: Error in initState: $e');
    }
  }

  Future<void> _initializeNotificationServices() async {
    try {
      print('🔔 [INIT] Starting notification services initialization...');

      // Initialize OneSignal first (for server push notifications)
      final notificationService = getIt<NotificationService>();
      await notificationService.initialize();
      print('🔔 [INIT] Notification service initialized');

      // Initialize background polling service
      final backgroundService = getIt<BackgroundChatService>();
      await backgroundService.initialize();
      print('🔔 [INIT] Background service initialized');

      // Check if user is logged in, then start polling
      // (Will be started after login in auth_service.dart)

      print('✅ [INIT] All notification services initialized successfully');
    } catch (e) {
      print('❌ [INIT] Error initializing notification services: $e');
      print('❌ [INIT] Stack trace: ${StackTrace.current}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Migrated App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          home: SplashScreen(param: SplashScreenParam()),
          onGenerateRoute: getIt<NavigationRoute>().generateRoute,
          localizationsDelegates: const [
            AltaLocalizationDelegate(),
          ],
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          locale: const Locale('en', 'US'),
        );
      },
    );
  }
}
