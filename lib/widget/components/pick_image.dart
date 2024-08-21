import 'package:image_picker/image_picker.dart';
import 'package:store_pos/core/service/image_cropper_service.dart';
import 'package:store_pos/core/util/extentions.dart';

Future<dynamic> customPickImageGallery({bool isEnableCrop = false}) async {
  final data = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 80,
  );
  if (data.isNull()) {
    return null;
  }
  if (isEnableCrop) {
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
