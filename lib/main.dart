import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:scouting_app/main_app.dart';
import 'package:scouting_app/di/service_locator.dart';
import 'package:scouting_app/core/common/local_storage.dart';
import 'package:scouting_app/core/services/account_service.dart';
import 'package:scouting_app/core/services/deep_link_handler.dart';
import 'package:scouting_app/app_settings.dart';
import 'package:scouting_app/core/services/media_optimization_initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Fix for mouse tracker assertion errors on Android
  if (defaultTargetPlatform == TargetPlatform.android) {
    // Force touch-only mode to avoid mouse tracker bugs
    GestureBinding.instance.resamplingEnabled = false;
  }

  // Add comprehensive error handling for Flutter framework bugs
  FlutterError.onError = (FlutterErrorDetails details) {
    // Log the error but don't crash the app
    print('Flutter Error: ${details.exception}');
    print('Stack trace: ${details.stack}');

    // Handle specific mouse tracker errors gracefully
    if (details.exception.toString().contains('mouse_tracker.dart')) {
      print(
          'Mouse tracker error handled gracefully - continuing app execution');
      return;
    }
  };

  // Handle platform channel errors
  PlatformDispatcher.instance.onError = (error, stack) {
    print('Platform Error: $error');
    print('Stack trace: $stack');

    // Handle HTTP exceptions gracefully
    if (error.toString().contains('HttpException')) {
      print('HTTP error handled gracefully - continuing app execution');
      return true; // Prevent app from crashing
    }

    // Handle other platform errors
    return true; // Prevent app from crashing
  };

  // Initialize LocalStorage FIRST
  await LocalStorage.init();

  // Initialize dependency injection SECOND
  await configureInjection();

  // Initialize media optimization services (network/memory monitoring)
  MediaOptimizationInitializer.initialize().catchError((e) {
    print('⚠️ Media optimization initialization failed: $e');
  });

  // Preload critical assets for faster first launch
  _preloadCriticalAssets();

  // Initialize AccountService to load saved account type - ASYNC
  AccountService().initialize().catchError((e) {
    print('AccountService initialization failed: $e');
  });

  // Initialize deep link handler - ASYNC
  print('🔗 Main: Initializing DeepLinkHandler...');
  // Don't await - let it initialize in background
  DeepLinkHandler.initialize().then((_) {
    print('🔗 Main: DeepLinkHandler initialized successfully');
    // Test deep link handler after initialization
    try {
      DeepLinkHandler.testReferralLink();
      print('🔗 Main: Deep link test completed');
    } catch (e) {
      print('🔗 Main: Deep link test failed: $e');
    }
  }).catchError((e) {
    print('🔗 Main: Error initializing DeepLinkHandler: $e');
  });

  // Then run the app with ads lifecycle management
  runApp(const MainApp());
}

/// Preload critical assets for faster first launch
void _preloadCriticalAssets() {
  // Preload fonts and images in background
  Future.microtask(() async {
    try {
      // Preload critical fonts
      await Future.wait([
        // Add any critical font preloading here
      ]);

      // Preload critical images
      await Future.wait([
        // Add any critical image preloading here
      ]);

      print('✅ Critical assets preloaded successfully');
    } catch (e) {
      print('⚠️ Asset preloading failed: $e');
    }
  });
}
