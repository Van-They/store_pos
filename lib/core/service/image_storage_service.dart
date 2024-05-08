import 'dart:async';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_pos/core/exception/exceptions.dart';

class ImageStorageService {
  static Future<String> saveImageToSecureDir(File imageFile) async {
    try {
      final compressedImg = await _imageCompressor(imageFile);
      if (compressedImg == null) throw GeneralException();
      final extension = compressedImg.absolute.path.split('.').last;
      final secureDir = await _getSecureDirectory();
      final fileName =
          'image_${DateTime.now().millisecondsSinceEpoch}.$extension';
      final destFile = File('${secureDir.path}/$fileName');
      await destFile.copy(destFile.path);
      return destFile.path;
    } catch (e) {
      return '';//Image not support
    }
  }

  static Future<File?> _imageCompressor(File imageFile) async {
    try {
      final extension = imageFile.absolute.path.split('.').last;
      final tmpDir = await getTemporaryDirectory();
      final tmpXFile = await FlutterImageCompress.compressAndGetFile(
        imageFile.absolute.path,
        tmpDir.absolute.path,
        quality: 50,
        autoCorrectionAngle: true,
      );
      final String xPath = tmpXFile?.path ?? '';
      if (xPath.isEmpty) throw GeneralException();

      final tmpFileName =
          'tmpImage_${DateTime.now().millisecondsSinceEpoch}.$extension';
      return File(join(xPath, tmpFileName));
    } catch (e) {
      return null;
    }
  }

  static Future<Directory> _getSecureDirectory() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final secureDir = Directory('${appDocDir.path}/secure_images');
    if (!await secureDir.exists()) {
      await secureDir.create(recursive: true);
    }
    return secureDir;
  }
}
