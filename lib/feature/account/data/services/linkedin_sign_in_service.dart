import 'dart:convert';
import 'package:http/http.dart' as http;

class LinkedInSignInService {
  Future<Map<String, dynamic>> getAccessToken(String authorizationCode) async {
    Map<String, dynamic> profileData =
        await fetchLinkedInUserProfile(authorizationCode);
    return profileData;
  }

  Future<Map<String, dynamic>> fetchLinkedInUserProfile(
      String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api.linkedin.com/v2/me'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print('Failed to fetch user profile: ${response.body}');
      throw Exception('Failed to fetch user profile: ${response.body}');
    }
  }
}
