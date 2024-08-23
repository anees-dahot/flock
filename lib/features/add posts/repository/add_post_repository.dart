import 'dart:convert';
import 'package:flock/utils/storage.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';

class AddPostRepository {
  Future<Map<String, dynamic>> addPost(
      {required String postText,
      required List<String> postImages,
      required List<String> postVideos,
      required String privacy}) async {
    String? token = await Storage().getData('token') as String;
    final response = await http.post(Uri.parse('$baseUrl/api/posts/add-post'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: json.encode({
          'postText': postText,
          'postImages': postImages,
          'postVideos': postVideos,
          'privacy': privacy,
        }));

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {'status': 200, 'message': responseBody['message']};
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }
}
