import 'dart:convert';

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

    if (response.statusCode == 200) {
      Storage().saveDate('token', jsonDecode(response.body)['token']);
      Storage().saveDate('id', jsonDecode(response.body)['_id']);
      return {
        'status': 200,
        'message': 'Logged in successfuly',
      };
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': jsonDecode(response.body)['msg']};
    } else if (response.statusCode == 500) {
      return {'status': 500, 'message': jsonDecode(response.body)['error']};
    } else {
      return {'status': 500, 'message': jsonDecode(response.body)['error']};
    }
  }
}
