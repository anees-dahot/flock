import 'dart:convert';

import 'package:flock/models/user.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';
import '../../../utils/storage.dart';

class CreateAccountRepository {
  Future<Map<String, dynamic>> createAccount(
      String fullName,
      String userName,
      String bio,
      String profileImage,
      int phoneNumber,
      DateTime dateOfBirth) async {
    String? token = await Storage().getData('token') as String?;

    // Check if the token is null
    if (token == null) {
      return {'status': 401, 'message': 'Unauthorized: Token is null'};
    }

    final response = await http.post(
      Uri.parse('$baseUrl/api/create-account'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      },
      body: json.encode({
        "fullName": fullName,
        "userName": userName,
        "Bio": bio,
        "profileImage": profileImage,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(json.decode(response.body)['user']);
 // Save user data in SharedPreferences
  await Storage().saveUserData(user);

  // Retrieve user data from SharedPreferences
  UserModel? savedUser = await Storage().getUserData();
  print(savedUser?.userName);

      return {
        'status': 200,
        'message': 'Created account successfully',
      };
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': jsonDecode(response.body)['msg']};
    } else if (response.statusCode == 500) {
      return {'status': 500, 'message': jsonDecode(response.body)['error']};
    } else {
      return {'status': 500, 'message': 'Unexpected error occurred'};
    }
  }
}
