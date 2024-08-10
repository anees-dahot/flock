import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';

class RegisterAccountRepository {
  Future<Map<String, dynamic>> registerAccount(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/signup'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return {'status': 200, 'message': 'Account created successfuly'};
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': jsonDecode(response.body)['msg']};
    } else if (response.statusCode == 500) {
      return {'status': 500, 'message': jsonDecode(response.body)['error']};
    } else {
      return {'status': 500, 'message': jsonDecode(response.body)['error']};
    }
  }
}
