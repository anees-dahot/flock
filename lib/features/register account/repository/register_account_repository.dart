import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';

class RegisterAccountRepository{
    Future<Map<String, dynamic>> registerAccount(
      {required String email, required String password}) async {
    final response = await http.post(Uri.parse('$baseUrl/api/signup'), body: {
      {"email": email, "password": password}
    });

    if (response.statusCode == 200) {
      return {'status': '200', 'message': 'Account created successfuly'};
    } else if (response.statusCode == 400) {
      return {'status': '400', 'message': 'Invalid credentials'};
    } else {
      return {'status': '500', 'message': 'An error occurred'};
    }
  }
}