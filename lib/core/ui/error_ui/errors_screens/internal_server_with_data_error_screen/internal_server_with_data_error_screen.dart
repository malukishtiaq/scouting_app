part of '../error_widget.dart';

class InternalServerWithDataErrorScreen extends StatefulWidget {
  final String? message;
  final VoidCallback? callback;
  final bool? disableRetryButton;
  final int errorCode;

  const InternalServerWithDataErrorScreen({
    super.key,
    this.message,
    this.callback,
    this.disableRetryButton,
    required this.errorCode,
  });

  @override
  State createState() => _InternalServerWithDataErrorScreenState();
}

class _InternalServerWithDataErrorScreenState
    extends State<InternalServerWithDataErrorScreen>
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
      content: widget.message,
      icon: Icons.refresh,
      imageUrl: AppConstants.ERROR_SERVER,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR_SERVER,
        animationController: _controller,
      ),
    );
  }
}
