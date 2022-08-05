import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageFunctions {
  Future<File?> imageFromGalary() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    return File(image.path);
  }

  Future<File?> imageFromCamera() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return null;
    return File(image.path);
  }
}
