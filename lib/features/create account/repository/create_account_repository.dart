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
    String token = await Storage().getData('token') as String;
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
        "dateOfBirth": dateOfBirth,
      }),
    );

    if (response.statusCode == 200) {
      UserModel userModel = UserModel(
          fullName: fullName,
          userName: userName,
          bio: bio,
          profileImage: profileImage,
          phoneNumber: phoneNumber,
          dateOfBirth: dateOfBirth);
      Storage().saveUser(userModel);
      var data = await Storage().getUser() as UserModel;
      print(data);
      print(data.fullName);
      Storage().saveDate('id', jsonDecode(response.body)['user']['_id']);
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
