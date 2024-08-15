import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
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
      String profileCover,
      int phoneNumber,
      DateTime dateOfBirth) async {
    String? token = await Storage().getData('token') as String;

    final cloudinary = CloudinaryPublic('doaewaso1', 'one9vigp');
    String image = '';
    String cover = '';

    final CloudinaryResponse res = await cloudinary
        .uploadFile(CloudinaryFile.fromFile(profileImage, folder: fullName));
    final CloudinaryResponse res2 = await cloudinary
        .uploadFile(CloudinaryFile.fromFile(profileCover, folder: fullName));
    image = res.secureUrl;
    cover = res2.secureUrl;

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
        "profileImage": image,
        "profileCover": cover,
        "phoneNumber": phoneNumber,
        "dateOfBirth": dateOfBirth.toIso8601String(),
      }),
    );

    if (response.statusCode == 200) {
      UserModel user = UserModel.fromJson(json.decode(response.body)['user']);

      await Storage().saveUserData(user);

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
