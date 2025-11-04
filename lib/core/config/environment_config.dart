enum Environment { kornerspot, quickdate, confidentialbee, beminetoday }
// 
// class EnvironmentConfig {
//   static Environment _environment = Environment.kornerspot;
// 
//   static void setEnvironment(Environment env) {
//     _environment = env;
//   }
// 
//   static String get baseUrl {
//     switch (_environment) {
//       case Environment.kornerspot:
//         return const String.fromEnvironment('BASE_URL',
//             defaultValue: 'https://www.kornerspot.com/endpoint/v1/');
//       case Environment.quickdate:
//         return const String.fromEnvironment('BASE_URL',
//             defaultValue: 'https://quickdate.com/endpoint/v1/');
//     }
//   }
// 
//   static String get serverKey {
//     switch (_environment) {
//       case Environment.kornerspot:
//         return const String.fromEnvironment('SERVER_KEY');
//       case Environment.quickdate:
//         return const String.fromEnvironment('API_TOKEN');
//     }
//   }
// 
//   static bool get isKornerspot => _environment == Environment.kornerspot;
//   static bool get isQuickdate => _environment == Environment.quickdate;
// }
