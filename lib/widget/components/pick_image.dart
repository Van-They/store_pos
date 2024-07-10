import 'package:image_picker/image_picker.dart';
import 'package:store_pos/core/service/image_cropper.dart';
import 'package:store_pos/core/util/extentions.dart';

Future<dynamic> customPickImageGallery({bool isEnableCropp = false}) async {
  final data = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (data.isNull()) {
    return null;
  }
  if (isEnableCropp) {
    final imgCrop = await customCropImage(imgFile: data);
    if (imgCrop == null) {
      return null;
    }
    return imgCrop;
  }
  return data;
}

Future<XFile?> customPickImageCamera() async {
  return await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 80);
}
