// dotenv dependency removed for now
// import 'package:linkedin_login/linkedin_login.dart';
// 
// class MicrosoftSignInService {
//   Future<UserSucceededAction?> signInWithMicrosoft() async {
//     MSALPublicClientApplication? _msal;
//     LinkedInUserWidget(
//       destroySession: false,
//       redirectUrl: "${dotenv.env['LINKDIN_redirectUrl']}",
//       clientId: "${dotenv.env['LINKDIN_clientId']}",
//       clientSecret: "${dotenv.env['LINKDIN_clientSecret']}",
//       onError: (value) async {
//         _linkedInUser = null;
//       },
//       onGetUserProfile: (UserSucceededAction linkedInUser) async {
//         _linkedInUser = linkedInUser;
//       },
//     );
//     return _linkedInUser;
//   }
// 
//   Future<void> _initializeMSAL() async {
//     _msal = MSALPublicClientApplication(
//       clientId: '<Your_Client_ID>',
//       authority: 'https://login.microsoftonline.com/common',
//     );
//   }
// 
//   Future<void> _login() async {
//     try {
//       final result = await _msal?.acquireToken(scopes: ['User.Read']);
//       print('Access Token: ${result?.accessToken}');
//     } catch (e) {
//       print('Error during login: $e');
//     }
//   }
// }
