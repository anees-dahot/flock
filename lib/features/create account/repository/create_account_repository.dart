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
    String? token = await Storage().getData('token') as String;

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
      // var responseData = jsonDecode(response.body)['user'];
      // UserModel userModel = UserModel.fromJson(responseData);
      // Storage().saveUser(userModel);
      // var data = await Storage().getUser() as UserModel;
      // print(data);
      // print(data.fullName);
      return {
        'status': 200,
        'message': 'Created account successfuly',
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
