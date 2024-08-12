import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';
import '../../../utils/storage.dart';

class LoginRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/signin'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({"email": email, "password": password}),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final token = responseBody['token'] as String?;
        if (token != null) {
          await Storage().saveDate('token', token);
          return {
            'status': 200,
            'message': 'Logged in successfully',
          };
        } else {
          return {
            'status': 500,
            'message': 'Token is missing in the response',
          };
        }
      } else if (response.statusCode == 400) {
        return {'status': 400, 'message': responseBody['msg'] ?? 'Bad Request'};
      } else {
        return {
          'status': response.statusCode,
          'message': responseBody['error'] ?? 'Unknown error'
        };
      }
    } catch (e) {
      return {'status': 500, 'message': 'An error occurred: ${e.toString()}'};
    }
  }
}
