part of '../error_widget.dart';

class BadRequestErrorScreenWidget extends StatefulWidget {
  final String? message;
  final void Function()? callback;

  const BadRequestErrorScreenWidget({
    super.key,
    this.message,
    this.callback,
  });

  @override
  State<BadRequestErrorScreenWidget> createState() =>
      _BadRequestErrorScreenWidgetState();
}

class _BadRequestErrorScreenWidgetState
    extends State<BadRequestErrorScreenWidget>
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
      disableRetryButton: false,
      title: widget.message ?? "badRequest".tr,
      imageUrl: AppConstants.ERROR_INVALID,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR,
        animationController: _controller,
      ),
    );
  }
}
