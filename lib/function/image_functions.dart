import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageFunctions {
  Future<File?> imageFromGalary() async {
    final XFile? _image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image == null) return null;
    return File(_image.path);
  }

  Future<File?> imageFromCamera() async {
    final XFile? _image =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (_image == null) return null;
    return File(_image.path);
  }
}
