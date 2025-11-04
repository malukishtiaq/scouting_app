// import 'package:scouting_app/core/common/extensions/extensions.dart';
// import 'package:scouting_app/core/constants/app/app_constants.dart';
// import 'package:scouting_app/core/navigation/nav.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:mutex/mutex.dart';
// 
// class FirebaseDynamicLinksWrapper {
//   static final staticServiceLock = Mutex();
//   static PendingDynamicLinkData? staticInitialLink;
// 
//   static final _fdl = FirebaseDynamicLinks.instance;
// 
//   static Future<void> init() async {
//     try {
//       final initialLink = await _fdl.getInitialLink();
//       if (initialLink != null) {
//         FirebaseDynamicLinksWrapper.staticInitialLink = initialLink;
//       } else {
//         "No Dynamic Link".logD;
//       }
//     } catch (e) {
//       e.toString().logE;
//     }
// 
//     _fdl.onLink.listen(
//       (event) async {
//         event.link.toString().logD;
//         _handleLink(event);
//       },
//       onError: (e) {
//         e.toString().logE;
//       },
//     );
//     await _fdl.app.setAutomaticDataCollectionEnabled(true);
//     await _fdl.app.setAutomaticResourceManagementEnabled(true);
//   }
// 
//   static Future<void> handleLaunchDynamicLink() async {
//     await FirebaseDynamicLinksWrapper.staticServiceLock.acquire();
// 
//     final initialLink = await _fdl.getInitialLink();
//     (initialLink ?? FirebaseDynamicLinksWrapper.staticInitialLink)
//         .toString()
//         .logI;
//     if (initialLink != null ||
//         FirebaseDynamicLinksWrapper.staticInitialLink != null) {
//       _handleLink(
//           initialLink ?? FirebaseDynamicLinksWrapper.staticInitialLink!);
//       FirebaseDynamicLinksWrapper.staticInitialLink = null;
//     } else {
//       "No Links".logW;
//     }
// 
//     FirebaseDynamicLinksWrapper.staticServiceLock.release();
//   }
// 
//   static Future<void> _handleLink(PendingDynamicLinkData linkData) async {
//     "Handling Link Navigation".logI;
//     linkData.link.toString().logW;
// 
//     if (linkData.link.queryParameters['center-details'] != null) {
//       Nav.to(
//         "DemoScreen.routeName",
//         arguments: {"id": "123"},
//       );
//     }
//   }
// 
//   static Future<Uri> createLink({
//     // required String linkName,
//     required Map<String, dynamic> parameters,
//     String? description,
//     Uri? image,
//   }) async {
//     final urlBody = parameters.entries
//             .where((e) => e.key.isNotEmpty && e.value != null)
//             .isEmpty
//         ? ""
//         : '?${parameters.entries.where((e) => e.key.isNotEmpty && e.value != null).map((e) => "${e.key}=${e.value}").join('&')}';
// 
//     final linkParam = DynamicLinkParameters(
//       link: Uri.parse("https://www.mss.com/app-links$urlBody"),
//       uriPrefix: 'https://mss.page.link',
//       androidParameters: const AndroidParameters(packageName: 'ae.mss.dev'),
//       iosParameters: const IOSParameters(bundleId: 'ae.mss.dev'),
//       socialMetaTagParameters: SocialMetaTagParameters(
//         title: AppConstants.TITLE_APP_NAME,
//         description: description,
//         imageUrl: image,
//       ),
//     );
//     final normalLink = await _fdl.buildLink(linkParam);
// 
//     final shortlinkParam = DynamicLinkParameters(
//       link: linkParam.link,
//       longDynamicLink: normalLink,
//       uriPrefix: linkParam.uriPrefix,
//       androidParameters: linkParam.androidParameters,
//       iosParameters: linkParam.iosParameters,
//       googleAnalyticsParameters: linkParam.googleAnalyticsParameters,
//       itunesConnectAnalyticsParameters:
//           linkParam.itunesConnectAnalyticsParameters,
//       navigationInfoParameters: linkParam.navigationInfoParameters,
//       socialMetaTagParameters: linkParam.socialMetaTagParameters,
//     );
//     try {
//       final shortLink = await _fdl.buildShortLink(
//         shortlinkParam,
//         shortLinkType: ShortDynamicLinkType.unguessable,
//       );
//       return shortLink.shortUrl;
//     } catch (e) {
//       return normalLink;
//     }
//   }
// }
