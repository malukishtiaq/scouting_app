import 'package:auto_size_text/auto_size_text.dart';
import 'package:scouting_app/export_files.dart' hide AppColors;
import 'package:scouting_app/core/common/app_colors.dart';
import 'package:scouting_app/core/navigation/nav.dart';
import 'package:flutter/material.dart';

import '../custom_elevated_button.dart';

Future<dynamic> showAppBottomSheet({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
  bool isDissmissable = true,
}) {
  return showModalBottomSheet(
    context: context,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height * 0.7,
      maxWidth: MediaQuery.of(context).size.width,
    ),
    isDismissible: isDissmissable,
    enableDrag: isDissmissable,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    builder: builder,
  );
}

class AppBottomSheet extends StatefulWidget {
  final String title;
  final TextStyle? titleStyle;
  final String? buttonText;
  final void Function(int? index)? onButtonPressed;
  final Widget Function(BuildContext context, int index)? itemsBuilder;
  final Widget Function(BuildContext context, int index)? seperatorBuilder;
  final int? itemsLength;
  final int? selectedItemIndex;
  final void Function(int index)? onItemTap;
  final Widget? child;
  final EdgeInsetsGeometry? contentPadding;
  final void Function()? initCallback;
  final bool showSelectionBackground;
  final bool centerTitle;
  final double? titleContentSpacing;
  final BorderRadius? itemBorderRadius;

  const AppBottomSheet({
    super.key,
    required this.title,
    this.titleStyle,
    this.buttonText,
    this.onButtonPressed,
    this.itemsBuilder,
    this.itemsLength,
    this.selectedItemIndex,
    this.seperatorBuilder,
    this.onItemTap,
    this.child,
    this.contentPadding,
    this.initCallback,
    this.showSelectionBackground = true,
    this.centerTitle = false,
    this.titleContentSpacing,
    this.itemBorderRadius,
  })  : assert((child != null) ^ (itemsBuilder != null)),
        assert(itemsBuilder == null || itemsLength != null);

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState<T> extends State<AppBottomSheet> {
  int? _selectedItemIndex;

  @override
  void initState() {
    super.initState();
    _selectedItemIndex = widget.selectedItemIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.initCallback?.call();
    });
  }

  @override
  void didUpdateWidget(AppBottomSheet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _selectedItemIndex = widget.selectedItemIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 500,
          maxWidth: double.maxFinite,
        ),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        padding: widget.contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: Container(
                height: 4,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.mssNeutral40,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              // width: 1,
              height: 50,
              padding: widget.contentPadding != null
                  ? widget.contentPadding!.horizontal > 0
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(
                          horizontal: 20,
                        )
                  : EdgeInsets.zero,
              child: widget.centerTitle
                  ? AutoSizeText(
                      widget.title.toUpperCase(),
                      // style: widget.titleStyle ??
                      // TextThemeStyles().h6(
                      //   color: AppColors.mssNavyBlue,
                      // ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    )
                  : Row(
                      children: [
                        // if (widget.centerTitle) const Spacer(),
                        Expanded(
                          child: AutoSizeText(
                            widget.title.toUpperCase(),
                            // style: widget.titleStyle ??
                            //     TextThemeStyles().h6(
                            //       color: AppColors.mssNavyBlue,
                            //     ),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () {
                              Nav.pop(null, false);
                            },
                            child: const Text(
                              "Close",
                              // style: TextThemeStyles().body3(
                              //   color: AppColors.mssRed,
                              //   decoration: TextDecoration.underline,
                              //   decorationColor: AppColors.mssRed,
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            SizedBox(
              height: widget.titleContentSpacing ?? 8,
            ),
            if (widget.child != null) widget.child!,
            if (widget.itemsBuilder != null)
              Container(
                constraints: const BoxConstraints(
                  maxHeight: 200,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < widget.itemsLength!; i++) ...{
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: widget.itemBorderRadius ??
                                BorderRadius.circular(100),
                            color: widget.showSelectionBackground &&
                                    _selectedItemIndex == i
                                ? AppColors.mssLightBlue
                                : null,
                          ),
                          alignment: AlignmentDirectional.centerStart,
                          child: Material(
                            type: MaterialType.transparency,
                            borderRadius: widget.itemBorderRadius ??
                                BorderRadius.circular(100),
                            child: InkWell(
                              borderRadius: widget.itemBorderRadius ??
                                  BorderRadius.circular(100),
                              onTap: () {
                                setState(() {
                                  _selectedItemIndex = i;
                                });
                                widget.onItemTap?.call(i);
                              },
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: widget.itemsBuilder!.call(context, i),
                              ),
                            ),
                          ),
                        ),
                        if (i + 1 < widget.itemsLength!)
                          widget.seperatorBuilder?.call(context, i) ??
                              const SizedBox(
                                height: 5,
                              ),
                      },
                    ],
                  ),
                ),
              ),
            if (widget.onButtonPressed != null) const SizedBox(height: 38),
            if (widget.onButtonPressed != null)
              CustomElevatedButton(
                text: "Done",
                onPressed: () =>
                    widget.onButtonPressed!.call(_selectedItemIndex),
              ),
          ],
        ),
      ),
    );
  }
}
