import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:scouting_app/core/common/app_colors.dart';
import 'package:scouting_app/core/constants/app/app_constants.dart';
import 'package:flutter/material.dart';

import '../../../../export_files.dart' hide AppColors;

class AppMessages extends StatefulWidget {
  const AppMessages({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<AppMessages> createState() => _AppMessagesState();

  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    context
        .findAncestorStateOfType<_AppMessagesState>()
        ?.show(message, isError, duration);
  }
}

class _AppMessagesState extends State<AppMessages>
    with SingleTickerProviderStateMixin {
  // final _height = AppConstants.appbarHeight + FIGMA_DESIGN_STATUS_BAR + 50.h;

  Duration _duration = const Duration(seconds: 3);
  String _message = '';
  double _position = 0;
  Timer? _timer;
  bool _isError = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // _position = -_height;

    _controller = AnimationController(vsync: this, duration: _duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned.fill(child: widget.child),
            AnimatedPositioned(
              top: _position,
              left: 0,
              right: 0,
              duration: const Duration(milliseconds: 200),
              child: Container(
                // height: _height,
                color: _isError ? AppColors.mssRed : AppColors.mssGreen,
                padding:
                    const EdgeInsets.only(top: FIGMA_DESIGN_STATUS_BAR + 10),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText(
                                _message,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                maxFontSize: 2.ceilToDouble() * 8,
                                minFontSize: 2.ceilToDouble() * 4,
                                stepGranularity: 2.ceilToDouble(),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            IconButton(
                              onPressed: _close,
                              icon: const Icon(
                                Icons.close,
                                size: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        height: 5,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              backgroundColor: _isError
                                  ? AppColors.mssRed
                                  : AppColors.mssGreen,
                              color: Colors.white,
                              value: _controller.value,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _playAnimation() {
    _controller.reset();
    _controller.duration = _duration;
    _controller.forward();
  }

  void _stopAnimation() {
    _controller.stop();
  }

  void _close() {
    _timer?.cancel();

    _stopAnimation();

    // setState(() {
    //   _position = -_height;
    // });
  }

  void show(String message, bool isError, Duration duration) {
    _timer?.cancel();
    setState(() {
      _message = message;
      _isError = isError;
      _duration = duration;
      _position = 0;
    });

    _playAnimation();

    _timer = Timer(_duration, () {
      // setState(() {
      //   _position = -_height;
      // });
      _stopAnimation();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();

    _controller.stop();
    _controller.dispose();

    super.dispose();
  }
}
