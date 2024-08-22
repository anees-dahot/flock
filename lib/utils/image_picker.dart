import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<XFile?> pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }

  static Future<List<XFile>?> pickMultipleImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();
    return images;
  }
}
