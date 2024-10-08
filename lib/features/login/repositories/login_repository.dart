import 'dart:convert';

import 'package:flock/models/user.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';
import '../../../utils/storage.dart';

class LoginRepository {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/signin'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({"email": email, "password": password}),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(json.decode(response.body)['user']);

      await Storage().saveUserData(user);
      final token = responseBody['token'] as String?;
      if (token != null) {
        await Storage().saveDate('token', token);
        return {'status': 200, 'message': 'Logged in successfully'};
      } else {
        return {'status': 500, 'message': 'Token is missing in the response'};
      }
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }
}
