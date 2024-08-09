import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<XFile?> pickImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }
}
