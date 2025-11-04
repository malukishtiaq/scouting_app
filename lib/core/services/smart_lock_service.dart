import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SmartLockService {
  static final LocalAuthentication _localAuth = LocalAuthentication();

  /// Check if biometric authentication is available
  static Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Get available biometric types
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      return [];
    }
  }

  /// Authenticate using biometrics
  static Future<bool> authenticateWithBiometrics({
    String reason = 'Please authenticate to continue',
  }) async {
    try {
      return await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (_) {
      return false;
    }
  }

  /// Store credentials securely (like Xamarin's CredentialManager)
  static Future<bool> storeCredentials({
    required String username,
    required String password,
    String? displayName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Store credentials in SharedPreferences (in production, use more secure storage)
      await prefs.setString('smart_lock_username', username);
      await prefs.setString('smart_lock_password', password);
      if (displayName != null) {
        await prefs.setString('smart_lock_display_name', displayName);
      }
      await prefs.setBool('smart_lock_enabled', true);

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Retrieve stored credentials
  static Future<Map<String, String>?> getStoredCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isEnabled = prefs.getBool('smart_lock_enabled') ?? false;

      if (!isEnabled) return null;

      final username = prefs.getString('smart_lock_username');
      final password = prefs.getString('smart_lock_password');

      if (username != null && password != null) {
        return {
          'username': username,
          'password': password,
        };
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Clear stored credentials
  static Future<bool> clearStoredCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('smart_lock_username');
      await prefs.remove('smart_lock_password');
      await prefs.remove('smart_lock_display_name');
      await prefs.setBool('smart_lock_enabled', false);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Check if smart lock is enabled
  static Future<bool> isSmartLockEnabled() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool('smart_lock_enabled') ?? false;
    } catch (e) {
      return false;
    }
  }

  /// Auto-fill credentials using biometric authentication
  static Future<Map<String, String>?> autoFillCredentials({
    String reason = 'Authenticate to auto-fill credentials',
  }) async {
    try {
      // First check if smart lock is enabled
      if (!await isSmartLockEnabled()) {
        return null;
      }

      // Authenticate with biometrics
      final isAuthenticated = await authenticateWithBiometrics(reason: reason);
      if (!isAuthenticated) {
        return null;
      }

      // Return stored credentials
      return await getStoredCredentials();
    } catch (e) {
      return null;
    }
  }

  /// Create credential request (like Xamarin's CreateCredentialRequest)
  static Future<bool> createCredentialRequest({
    required String username,
    required String password,
    String? displayName,
  }) async {
    try {
      // First authenticate with biometrics
      final isAuthenticated = await authenticateWithBiometrics(
        reason: 'Authenticate to save credentials',
      );

      if (!isAuthenticated) {
        return false;
      }

      // Store credentials
      return await storeCredentials(
        username: username,
        password: password,
        displayName: displayName,
      );
    } catch (e) {
      return false;
    }
  }
}
