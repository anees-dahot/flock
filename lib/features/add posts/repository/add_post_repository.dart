import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flock/utils/storage.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';

class AddPostRepository {
  Future<Map<String, dynamic>> addPost(
      {required String postText, required List<String> postVideos}) async {
    final String type = await Storage().getData('visibilityType') as String;
    final List<String>? images =
        await Storage().getList('images') as List<String>?;
    final cloudinary = CloudinaryPublic('doaewaso1', 'one9vigp');
    List<String> imageUrl = [];
    if (images != null) {
  
        for (int i = 0; i < images.length; i++) {
        final CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i], folder: _generateRandomString()));
        imageUrl.add(res.secureUrl);
      }
     
    }
    String? token = await Storage().getData('token') as String;
    final response = await http.post(Uri.parse('$baseUrl/api/posts/add-post'),
        headers: {
          'Content-Type': 'application/json',
          'x-auth-token': token,
        },
        body: json.encode({
          'postText': postText,
          'postImages': imageUrl,
          'postVideos': postVideos,
          'privacy': type,
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

  String _generateRandomString([int length = 10]) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[(index % chars.length)]).join();
  }
}