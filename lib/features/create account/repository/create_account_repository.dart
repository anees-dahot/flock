import 'package:flock/utils/app_urls.dart';
import 'package:http/http.dart' as http;

class CreateAccountRepository {
  Future<Map<String, dynamic>> createAccount(
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
