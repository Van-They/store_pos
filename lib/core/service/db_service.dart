import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  DbService._();

  static Database? _database;

  Future<Database> get detabase async => _database ??= await initDatabase();

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'store_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) {
    final batch = db.batch();

    // batch.execute('''''');

    batch.commit();
  }
}
