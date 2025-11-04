part of '../error_widget.dart';

class NotFoundErrorScreenWidget extends StatefulWidget {
  final VoidCallback callback;
  final bool? disableRetryButton;
  final String url;

  const NotFoundErrorScreenWidget({
    super.key,
    required this.callback,
    this.disableRetryButton,
    required this.url,
  });

  @override
  State createState() => _NotFoundErrorScreenWidgetState();
}

class _NotFoundErrorScreenWidgetState extends State<NotFoundErrorScreenWidget>
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
      content: "notFound".trWithArgs({"url": widget.url}),
      icon: Icons.refresh,
      imageUrl: AppConstants.ERROR_EMPTY,
      errorAnimation: ErrorAnimation(
        animUrl: AppConstants.ANIM_LOTTIE_ERROR_EMPTY,
        animationController: _controller,
      ),
    );
  }
}
