import 'dart:convert';

import 'package:flock/models/user.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';
import '../../../utils/storage.dart';

class SuggestedFriendsRepository {
  Future<Map<String, dynamic>> getSuggestedFriends() async {
    String? token = await Storage().getData('token') as String;

    final response = await http.get(
      Uri.parse('$baseUrl/api/suggested-friends'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<UserModel> suggestedFriends =
          data.map((userJson) => UserModel.fromJson(userJson)).toList();
      return {
        'status': 200,
        'message': 'Data loaded successfully',
        'data': suggestedFriends
      };
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }
}
