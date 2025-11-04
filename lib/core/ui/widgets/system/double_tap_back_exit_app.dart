// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:scouting_app/localization/app_localization.dart';
// 
// import '../../show_toast.dart';
// 
// class DoubleTapBackExitApp extends StatefulWidget {
//   const DoubleTapBackExitApp({
//     super.key,
//     required this.child,
//     this.duration = const Duration(milliseconds: 2500),
//   });
// 
//   final Widget child;
//   final Duration duration;
// 
//   @override
//   State createState() => _DoubleTapBackExitAppState();
// }
// 
// class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
//   DateTime _lastTime = DateTime.now();
// 
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _isExit(context),
//       child: widget.child,
//     );
//   }
// 
//   Future<bool> _isExit(BuildContext context) async {
//     // if (context.read<AppMainScreenNotifier>().selectedPage != 0) {
//     //   context.read<AppMainScreenNotifier>().onPageTap(0);
//     //   return Future.value(false);
//     // } else {
//       Scrollable.ensureVisible(
//         context
//         //     .read<AppMainScreenNotifier>()
//         //     .homeSearchFieldKey
//         //     .currentContext!,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//         alignment: 1,
//         alignmentPolicy: ScrollPositionAlignmentPolicy.explicit,
//       );
//     }
//     // if (DateTime.now().difference(_lastTime) > widget.duration) {
//       _lastTime = DateTime.now();
//       // CustomToast.show("pressTwiceToExit".tr);
//       return Future.value(false);
//     }
//     await SystemNavigator.pop();
//     return Future.value(true);
//   }
// }
