import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';
import 'package:store_pos/core/util/extentions.dart';

class XlsxFileReader {
  XlsxFileReader._();
  static File? _file;

  static Future<void> loadFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['xlsx'],
      );

      if (result.isNull()) {
        return;
      }

      _file = File(result!.files.single.path!);
    } on Exception {
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> readItem() async {
    try {
      final bytes = await _file!.readAsBytes();
      var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      final List<Map<String, dynamic>> modelList = [];
      for (var table in decoder.tables.keys) {
        if (table == 'menu') {
          final List<String> listKey =
              decoder.tables[table]!.rows[0].cast<String>();
          for (int i = 1; i < decoder.tables[table]!.rows.length; i++) {
            final row = decoder.tables[table]!.rows[i];
            final Map<String, dynamic> tmpMap = Map.fromIterables(listKey, row);
            tmpMap['displayLang'] = 'KH';
            modelList.add(tmpMap);
          }
        }
      }
      _file = null;
      return modelList;
    } catch (e) {
      return [];
    }
  }
}
