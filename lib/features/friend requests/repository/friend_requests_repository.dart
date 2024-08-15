import 'dart:convert';

import 'package:flock/models/user.dart';
import 'package:flock/utils/storage.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';

class FriendRequestsRepository {
  Future<Map<String, dynamic>> getFriendRequests() async {
    String? token = await Storage().getData('token') as String;
    final response = await http.get(
      Uri.parse('$baseUrl/api/get-friend-requests'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody;
      final List<UserModel> friendRequests =
          data.map((userJson) => UserModel.fromJson(userJson)).toList();
      print(friendRequests);
      print(friendRequests[0].fullName);
      return {
        'status': 200,
        'message': 'Logged in successfully',
        'data': friendRequests
      };
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }
}
