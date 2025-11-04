import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:gal/gal.dart';
import '../constants/website_constants.dart';
import '../../di/service_locator.dart';
import '../providers/session_data.dart';

/// Comprehensive Referral Sharing Service
/// Handles sharing referral links via WhatsApp, email, system share, and QR code
@singleton
class ReferralSharingService {
  static const String _referralMessageTemplate = '''
🎉 Join me on Social Bee!

Get connected with friends and discover amazing content. Use my referral link to get started:

{referralLink}

Download the app and let's connect! 🚀
''';

  /// Share referral link via WhatsApp
  static Future<ShareResult> shareViaWhatsApp({
    required String referralLink,
    String? customMessage,
  }) async {
    try {
      final message = customMessage ??
          _referralMessageTemplate.replaceAll('{referralLink}', referralLink);
      final whatsappUrl =
          'whatsapp://send?text=${Uri.encodeComponent(message)}';

      final uri = Uri.parse(whatsappUrl);
      final launched = await launchUrl(uri);

      if (launched) {
        return ShareResult.success('WhatsApp opened successfully');
      } else {
        // Fallback to web WhatsApp
        final webWhatsappUrl =
            'https://web.whatsapp.com/send?text=${Uri.encodeComponent(message)}';
        final webUri = Uri.parse(webWhatsappUrl);
        final webLaunched =
            await launchUrl(webUri, mode: LaunchMode.externalApplication);

        if (webLaunched) {
          return ShareResult.success('Web WhatsApp opened successfully');
        } else {
          return ShareResult.failure('Could not open WhatsApp');
        }
      }
    } catch (e) {
      return ShareResult.failure('WhatsApp sharing failed: $e');
    }
  }

  /// Share referral link via email
  static Future<ShareResult> shareViaEmail({
    required String referralLink,
    String? customSubject,
    String? customMessage,
    List<String>? recipients,
  }) async {
    try {
      final subject = customSubject ?? 'Join me on Social Bee! 🎉';
      final message = customMessage ??
          _referralMessageTemplate.replaceAll('{referralLink}', referralLink);

      String emailUrl = 'mailto:';
      if (recipients != null && recipients.isNotEmpty) {
        emailUrl += recipients.join(',');
      }
      emailUrl +=
          '?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(message)}';

      final uri = Uri.parse(emailUrl);
      final launched = await launchUrl(uri);

      if (launched) {
        return ShareResult.success('Email client opened successfully');
      } else {
        return ShareResult.failure('Could not open email client');
      }
    } catch (e) {
      return ShareResult.failure('Email sharing failed: $e');
    }
  }

  /// Share referral link via system share
  static Future<ShareResult> shareViaSystem({
    required String referralLink,
    String? customMessage,
    String? subject,
  }) async {
    try {
      final message = customMessage ??
          _referralMessageTemplate.replaceAll('{referralLink}', referralLink);

      await Share.share(
        message,
        subject: subject ?? 'Join me on Social Bee!',
      );

      return ShareResult.success('System share dialog opened');
    } catch (e) {
      return ShareResult.failure('System sharing failed: $e');
    }
  }

  /// Generate and share QR code for referral link
  static Future<ShareResult> shareViaQRCode({
    required String referralLink,
    required BuildContext context,
    String? customMessage,
  }) async {
    try {
      // Generate QR code
      final qrCodeData = await _generateQRCodeData(referralLink);

      // Show QR code dialog
      await _showQRCodeDialog(
        context: context,
        qrCodeData: qrCodeData,
        referralLink: referralLink,
        customMessage: customMessage,
      );

      return ShareResult.success('QR code generated successfully');
    } catch (e) {
      return ShareResult.failure('QR code generation failed: $e');
    }
  }

  /// Generate QR code data
  static Future<Uint8List> _generateQRCodeData(String referralLink) async {
    try {
      final qrCode = QrCode.fromData(
        data: referralLink,
        errorCorrectLevel: QrErrorCorrectLevel.M,
      );

      final painter = QrPainter.withQr(
        qr: qrCode,
        color: const Color(0xFF000000),
        emptyColor: const Color(0xFFFFFFFF),
      );

      final picData = await painter.toImageData(200);
      return picData!.buffer.asUint8List();
    } catch (e) {
      throw Exception('Failed to generate QR code: $e');
    }
  }

  /// Show QR code dialog with sharing options
  static Future<void> _showQRCodeDialog({
    required BuildContext context,
    required Uint8List qrCodeData,
    required String referralLink,
    String? customMessage,
  }) async {
    return showDialog(
      context: context,
      builder: (context) => QRCodeDialog(
        qrCodeData: qrCodeData,
        referralLink: referralLink,
        customMessage: customMessage,
      ),
    );
  }

  /// Copy referral link to clipboard
  static Future<ShareResult> copyToClipboard({
    required String referralLink,
    String? customMessage,
  }) async {
    try {
      final message = customMessage ??
          _referralMessageTemplate.replaceAll('{referralLink}', referralLink);
      await Clipboard.setData(ClipboardData(text: message));
      return ShareResult.success('Link copied to clipboard');
    } catch (e) {
      return ShareResult.failure('Failed to copy to clipboard: $e');
    }
  }

  /// Save QR code to gallery
  static Future<ShareResult> saveQRCodeToGallery({
    required Uint8List qrCodeData,
    String? fileName,
  }) async {
    try {
      // Check if we have permission to save to gallery
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final granted = await Gal.requestAccess();
        if (!granted) {
          return ShareResult.failure('Gallery access denied');
        }
      }

      // Save the image to gallery
      await Gal.putImageBytes(
        qrCodeData,
        name: fileName ??
            'referral_qr_code_${DateTime.now().millisecondsSinceEpoch}',
      );

      return ShareResult.success('QR code saved to gallery');
    } catch (e) {
      return ShareResult.failure('Gallery save failed: $e');
    }
  }

  /// Generate referral link with current user's username
  static String generateReferralLink() {
    try {
      final sessionData = getIt<SessionData>();
      final username = sessionData.userProfile?.username ?? 'user';
      final websiteUrl = WebsiteConstants.websiteUrl;
      final referralLink = '$websiteUrl/register?ref=$username';
      print('🔗 Generated referral link: $referralLink');
      return referralLink;
    } catch (e) {
      // Fallback to default
      final websiteUrl = WebsiteConstants.websiteUrl;
      final referralLink = '$websiteUrl/register?ref=user';
      print('🔗 Generated fallback referral link: $referralLink');
      return referralLink;
    }
  }

  /// Get available sharing platforms
  static List<SharePlatform> getAvailablePlatforms() {
    return [
      SharePlatform.whatsapp,
      SharePlatform.email,
      SharePlatform.system,
      SharePlatform.qrCode,
      SharePlatform.copy,
    ];
  }
}

/// Share result model
class ShareResult {
  final bool isSuccess;
  final String message;

  ShareResult._(this.isSuccess, this.message);

  factory ShareResult.success(String message) => ShareResult._(true, message);
  factory ShareResult.failure(String message) => ShareResult._(false, message);
}

/// Share platform enum
enum SharePlatform {
  whatsapp,
  email,
  system,
  qrCode,
  copy,
  twitter,
  instagram,
  facebook,
}

/// QR Code Dialog Widget
class QRCodeDialog extends StatelessWidget {
  final Uint8List qrCodeData;
  final String referralLink;
  final String? customMessage;

  const QRCodeDialog({
    super.key,
    required this.qrCodeData,
    required this.referralLink,
    this.customMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Scan QR Code',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),

            // QR Code
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Image.memory(
                qrCodeData,
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),

            // Referral Link
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: SelectableText(
                referralLink,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _copyLink(context),
                    child: const Text('Copy Link'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _saveToGallery(context),
                    child: const Text('Save QR'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _copyLink(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: referralLink));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link copied to clipboard'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  void _saveToGallery(BuildContext context) async {
    try {
      final result = await ReferralSharingService.saveQRCodeToGallery(
        qrCodeData: qrCodeData,
        fileName: 'referral_qr_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            backgroundColor: result.isSuccess ? Colors.green : Colors.red,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
