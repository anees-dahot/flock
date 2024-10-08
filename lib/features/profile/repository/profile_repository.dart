import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flock/models/user.dart';
import 'package:flock/utils/app_urls.dart';
import 'package:flock/utils/storage.dart';

class ProfileRepository {
  Future<Map<String, dynamic>> getFriendRequests(String userId) async {
    String? token = await Storage().getData('token') as String;
    final response = await http.get(
      Uri.parse('$baseUrl/api/get-friends/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody;
      final List<UserModel> friends =
          data.map((userJson) => UserModel.fromJson(userJson)).toList();
      return {'status': 200, 'data': friends};
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }
}
