part of '../error_widget.dart';

class LoginRequiredErrorScreen extends StatefulWidget {
  final VoidCallback? callback;
  final bool? disableRetryButton;

  const LoginRequiredErrorScreen({
    super.key,
    this.callback,
    this.disableRetryButton,
  });

  @override
  State createState() => _LoginRequiredErrorScreenState();
}

class _LoginRequiredErrorScreenState extends State<LoginRequiredErrorScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildErrorScreen(
      callback: widget.callback,
      context: context,
      disableRetryButton: widget.disableRetryButton ?? false,
      content: "loginErrorRequired".tr,
      icon: Icons.refresh,
      imageUrl: AppConstants.ANIM_LOTTIE_ERROR_403_401,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR_403_401,
        animationController: _controller,
      ),
    );
  }
}
