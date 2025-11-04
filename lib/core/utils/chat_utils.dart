import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';

class ChatUtils {
  /// Decrypts a chat message using AES encryption
  /// The password is typically the message timestamp
  static String getMessage(String encryptedText, String password) {
    if (encryptedText.isEmpty || password.isEmpty) {
      return encryptedText;
    }

    try {
      // Decode base64 encrypted text
      final encryptedBytes = base64Decode(encryptedText);

      // Create encryption key from password (first 16 bytes)
      final keyBytes = _createKeyFromPassword(password);

      // Create IV from the same key (ECB mode uses key as IV)
      final iv = IV(keyBytes);

      // Create encrypter with AES-128-ECB
      final encrypter =
          Encrypter(AES(Key(keyBytes), mode: AESMode.ecb, padding: 'PKCS7'));

      // Decrypt the message
      final encrypted = Encrypted(encryptedBytes);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      return decrypted;
    } catch (e) {
      // If decryption fails, return original text
      print('Chat decryption error: $e');
      return encryptedText;
    }
  }

  /// Creates a 16-byte key from password string
  /// Matches the Xamarin implementation
  static Uint8List _createKeyFromPassword(String password) {
    final keyBytes = Uint8List(16);
    final passwordBytes = utf8.encode(password);

    // Copy password bytes to key, padding with zeros if needed
    for (int i = 0; i < 16 && i < passwordBytes.length; i++) {
      keyBytes[i] = passwordBytes[i];
    }

    return keyBytes;
  }

  /// Encrypts a chat message using AES encryption
  /// Used when sending messages
  static String encryptMessage(String plainText, String password) {
    if (plainText.isEmpty || password.isEmpty) {
      return plainText;
    }

    try {
      // Create encryption key from password
      final keyBytes = _createKeyFromPassword(password);

      // Create IV from the same key (ECB mode uses key as IV)
      final iv = IV(keyBytes);

      // Create encrypter with AES-128-ECB
      final encrypter =
          Encrypter(AES(Key(keyBytes), mode: AESMode.ecb, padding: 'PKCS7'));

      // Encrypt the message
      final encrypted = encrypter.encrypt(plainText, iv: iv);

      // Return base64 encoded encrypted data
      return base64.encode(encrypted.bytes);
    } catch (e) {
      print('Chat encryption error: $e');
      return plainText;
    }
  }
}
