import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ImageStorageService{
  static Future<String> saveImageToSecureDir(File imageFile) async {
    try {
      final extension = imageFile.absolute.path.split('.').last;
      final secureDir = await _getSecureDirectory();
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.$extension';
      final destFile = File('${secureDir.path}/$fileName');
      await imageFile.copy(destFile.path);
      return destFile.path;
    } catch (e) {
     rethrow;
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