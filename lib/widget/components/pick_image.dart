import 'package:image_picker/image_picker.dart';

Future<XFile?> customPickImageGallery() async {
  return await ImagePicker().pickImage(source: ImageSource.gallery);
}

Future<XFile?> customPickImageCamera() async {
  return await ImagePicker().pickImage(source: ImageSource.camera);
}
