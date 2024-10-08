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

  Future<Map<String, dynamic>> acceptFriendRequests(String userId) async {
    String? token = await Storage().getData('token') as String;
    final response = await http.post(
      Uri.parse('$baseUrl/api/accept-friend-requests/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['friendRequests'];
      final List<UserModel> friendRequests =
          data.map((userJson) => UserModel.fromJson(userJson)).toList();
      return {
        'status': 200,
        'message': responseBody['message'],
        'data': friendRequests
      };
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }

  Future<Map<String, dynamic>> deleteFriendRequests(String userId) async {
    String? token = await Storage().getData('token') as String;
    final response = await http.post(
      Uri.parse('$baseUrl/api/delete-friend-request/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['requests']; // Change this line
      final List<UserModel> friendRequests =
          data.map((userJson) => UserModel.fromJson(userJson)).toList();
      return {
        'status': 200,
        'message': 'Request deleted successfuly',
        'data': friendRequests
      };
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      print(responseBody['errro']);
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }
}
