import 'dart:async';
import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:store_pos/core/exception/exceptions.dart';
import 'package:store_pos/core/util/helper.dart';

class ImageStorageService {
  static Future<String> saveImageToSecureDir(
    File imageFile, {
    String path = '',
  }) async {
    try {
      final destFile = File(path);
      await imageFile.copy(destFile.path);
      return destFile.path;
    } catch (e) {
      return '';
    }
  }

  static Future<String> initImgPathTmp(File imageFile) async {
    try {
      logger.d("original image path ${imageFile.path}");
      final extension = imageFile.absolute.path.split('.').last;
      final secureDir = await _getSecureDirectory();
      final fileName =
          'image_${DateTime.now().millisecondsSinceEpoch}.$extension';
      final filePath = '${secureDir.path}/$fileName';
      logger.d("temp image path $filePath");
      return filePath;
    } catch (e) {
      return '';
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
        format: CompressFormat.png,
        autoCorrectionAngle: true,
      );
      final String xPath = tmpXFile?.path ?? '';

      if (xPath.isEmpty) throw GeneralException();

      final tmpFileName =
          'tmpImage_${DateTime.now().millisecondsSinceEpoch}.$extension';
      return File(join(xPath, tmpFileName));
    } catch (e) {
      rethrow;
    }
  }

  static Future<Directory> _getSecureDirectory() async {
    final appDocDir = await getExternalStorageDirectory();
    final secureDir = Directory('${appDocDir!.path}/secure_images');
    if (!await secureDir.exists()) {
      await secureDir.create(recursive: true);
    }
    return secureDir;
  }

  static Future<void> onClearCache(String path) async {
    try {
      if (path.isEmpty) {
        return;
      }
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      rethrow;
    }
  }
}
