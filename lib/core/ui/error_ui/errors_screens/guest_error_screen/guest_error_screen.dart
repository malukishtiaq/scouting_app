part of '../error_widget.dart';

class GuestErrorScreenWidget extends StatefulWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;

  const GuestErrorScreenWidget({
    super.key,
    required this.callback,
    this.disableRetryButton,
  });

  @override
  State createState() => _GuestErrorScreenWidgetState();
}

class _GuestErrorScreenWidgetState extends State<GuestErrorScreenWidget>
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
      disableRetryButton: widget.disableRetryButton ?? true,
      content: "guetsMessage".tr,
      icon: Icons.refresh,
      imageUrl: AppConstants.ERROR_EMPTY,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR_EMPTY,
        animationController: _controller,
      ),
    );
  }
}
