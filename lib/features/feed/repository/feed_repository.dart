import 'dart:convert';

import 'package:flock/models/post.dart';
import 'package:flock/utils/app_urls.dart';
import 'package:flock/utils/storage.dart';
import 'package:http/http.dart' as http;

class FeedRepository {
  Future<Map<String, dynamic>> getPosts() async {
    String? token = await Storage().getData('token') as String;
    final response = await http.get(
      Uri.parse('$baseUrl/api/posts/get-posts'),
      headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      },
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> data = responseBody['posts'];
      final List<Post> posts =
          data.map((posts) => Post.fromMap(posts)).toList();

      return {'status': 200, 'message': responseBody['message'], 'data': posts};
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }
}
