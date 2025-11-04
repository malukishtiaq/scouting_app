import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state_m/account/account_cubit.dart';

class VerificationScreenContent extends StatefulWidget {
  final String typeCode; // "TwoFactor" or "AccountSms"

  const VerificationScreenContent({
    super.key,
    required this.typeCode,
  });

  @override
  State<VerificationScreenContent> createState() =>
      _VerificationScreenContentState();
}

class _VerificationScreenContentState extends State<VerificationScreenContent> {
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Code'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_login.xml'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Logo Section
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 20),
                child: Image.asset(
                  'assets/images/icons/logo.webp',
                  height: 80,
                  width: 80,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Icon(
                      Icons.security,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Main Content with rounded dialog background
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title based on type
                        Center(
                          child: Text(
                            _getTitle(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF22172A),
                            ),
                          ),
                        ),

                        // Description
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Center(
                            child: Text(
                              _getDescription(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF666666),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Error Message Display
                        if (_errorMessage != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: const Color(0xFFFFCDD2)),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  color: Color(0xFFD32F2F),
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _errorMessage!,
                                    style: const TextStyle(
                                      color: Color(0xFFD32F2F),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _errorMessage = null;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Color(0xFFD32F2F),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        // Verification Code Field
                        const Text(
                          'Verification Code',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF22172A),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 52,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: TextFormField(
                            controller: _codeController,
                            keyboardType: TextInputType.number,
                            maxLength: 6,
                            decoration: const InputDecoration(
                              hintText: 'Enter 6-digit code',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF999999),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              counterText: '', // Hide character counter
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Verify Button
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF7200F6), Color(0xFFBD00FD)],
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Stack(
                            children: [
                              // Verify Button
                              if (!_isLoading)
                                ElevatedButton(
                                  onPressed: _handleVerification,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                  child: const Text(
                                    'Verify',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              // Progress Bar (when loading)
                              if (_isLoading)
                                const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Resend Code Option
                        Center(
                          child: GestureDetector(
                            onTap: _isLoading ? null : _handleResendCode,
                            child: Text(
                              'Didn\'t receive code? Resend',
                              style: TextStyle(
                                fontSize: 14,
                                color: _isLoading
                                    ? const Color(0xFFCCCCCC)
                                    : const Color(0xFF7200F6),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),

                        // Bottom spacing
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    switch (widget.typeCode) {
      case 'TwoFactor':
        return 'Two-Factor Authentication';
      case 'AccountSms':
        return 'Account Verification';
      default:
        return 'Verification Code';
    }
  }

  String _getDescription() {
    switch (widget.typeCode) {
      case 'TwoFactor':
        return 'Please enter the 6-digit verification code sent to your device to complete the login process.';
      case 'AccountSms':
        return 'Please enter the verification code sent to your phone number to activate your account.';
      default:
        return 'Please enter the verification code to continue.';
    }
  }

  void _handleVerification() {
    // Clear previous error
    setState(() {
      _errorMessage = null;
    });

    // Validate input
    if (_codeController.text.trim().isEmpty) {
      setState(() {
        _errorMessage = 'Please enter the verification code';
      });
      return;
    }

    if (_codeController.text.trim().length < 6) {
      setState(() {
        _errorMessage = 'Please enter a valid 6-digit code';
      });
      return;
    }

    // Show loading state
    setState(() {
      _isLoading = true;
    });

    // Call the cubit 2FA verification method
    final cubit = context.read<AccountCubit>();
    cubit.verifyTwoFactor(_codeController.text.trim());
  }

  void _handleResendCode() {
    // TODO: Implement resend code functionality
    setState(() {
      _errorMessage = 'Resend code functionality coming soon!';
    });
  }
}
