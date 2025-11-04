import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// [ResponsiveWidget] is a widget to add the orientation value for -
/// [ResponsiveBuilder] that has no orientation param
class ResponsiveWidget extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation sizingInformation,
    Orientation oreintation,
  ) builder;

  const ResponsiveWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInfo) {
        return builder(
          context,
          sizingInfo,
          MediaQuery.of(context).orientation,
        );
      },
    );
  }
}
