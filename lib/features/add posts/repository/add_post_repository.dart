import 'dart:convert';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flock/utils/storage.dart';
import 'package:http/http.dart' as http;

import '../../../utils/app_urls.dart';

class AddPostRepository {
  Future<Map<String, dynamic>> addPost({
    required String postText,
    required List<String> postVideos,
    required Function(double)? onProgress,
  }) async {
    final String type = await Storage().getData('visibilityType') as String;
    final List<String>? images = await Storage().getList('images');

    print('repo ran ' + (images?.length ?? 0).toString());

    List<String> imageUrl = [];
    int totalSteps =
        (images?.length ?? 0) + 1; // Number of images + 1 for the post text
    int currentStep = 0;

    // Simulate initial progress for text post
    if (images == null || images.isEmpty) {
      await simulateGradualProgress(
          onProgress, 0, 0.5, 3000); // Simulate 50% progress over 3 seconds
      currentStep++;
    }

    if (images != null && images.isNotEmpty) {
      final cloudinary = CloudinaryPublic('doaewaso1', 'one9vigp');
      for (int i = 0; i < images.length; i++) {
        try {
          final CloudinaryResponse res = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(images[i],
                  folder: _generateRandomString()));
          imageUrl.add(res.secureUrl);
          currentStep++;
          if (onProgress != null) {
            onProgress(currentStep / totalSteps);
          }
        } catch (e) {
          print('Error uploading image: $e');
          // Optionally handle the error, e.g., skip this image or return an error
        }
      }
    }

    await simulateGradualProgress(onProgress, currentStep / totalSteps, 1,
        3000); // Simulate final 50% progress over 3 seconds
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

    currentStep++;
    if (onProgress != null) {
      onProgress(currentStep / totalSteps);
    }

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {'status': 200, 'message': responseBody['message']};
    } else if (response.statusCode == 400) {
      return {'status': 400, 'message': responseBody['msg']};
    } else {
      return {'status': response.statusCode, 'message': responseBody['error']};
    }
  }

  Future<void> simulateGradualProgress(Function(double)? onProgress,
      double start, double end, int duration) async {
    int steps = 20; // Number of steps to break the duration into
    double stepProgress = (end - start) / steps;
    int stepDuration =
        (duration ~/ steps); // Duration for each step in milliseconds

    for (int i = 0; i < steps; i++) {
      await Future.delayed(Duration(milliseconds: stepDuration), () {
        if (onProgress != null) {
          onProgress(start + (stepProgress * i));
        }
      });
    }
  }

  String _generateRandomString([int length = 10]) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    return List.generate(length, (index) => chars[(index % chars.length)])
        .join();
  }
}
