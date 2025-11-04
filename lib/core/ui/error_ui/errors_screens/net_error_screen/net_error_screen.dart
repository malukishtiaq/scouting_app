part of '../error_widget.dart';

class NetErrorScreen extends StatefulWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;
  const NetErrorScreen({
    super.key,
    required this.callback,
    this.disableRetryButton,
  });

  @override
  State createState() => _NetErrorScreenState();
}

class _NetErrorScreenState extends State<NetErrorScreen>
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
      title: "connectionErrorMessage".tr,
      context: context,
      callback: widget.callback,
      disableRetryButton: widget.disableRetryButton ?? false,
      // content: Translation.of(context).connectionErrorMessage,
      icon: Icons.refresh,
      imageUrl: AppConstants.ERROR_INVALID,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR,
        animationController: _controller,
      ),
    );
  }
}
