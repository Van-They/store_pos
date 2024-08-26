import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_pos/core/data/model/customer_model.dart';
import 'package:store_pos/core/data/model/payment_method_model.dart';
import 'package:store_pos/core/data/model/setting_model.dart';

class AppDatabase {
  AppDatabase._();

  static Database? _database;

  static final AppDatabase instance = AppDatabase._();

  Future<Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    // String externalPath = await getDatabasesPath();
    final dir = await getExternalStorageDirectory();
    Directory extentDir = Directory('${dir?.path}/database');
    if (!await extentDir.exists()) {
      extentDir.create(recursive: true);
    }
    String path = join(extentDir.path, 'store_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    final loadScript = await rootBundle.loadString("asset/sql/db_scripts.sql");

    List<String> sqlStatements = loadScript.split(';');

    final batch = db.batch();

    for (var statement in sqlStatements) {
      if (statement.trim().isNotEmpty) {
        batch.execute(statement);
      }
    }
    await batch.commit();

    await _onPrePopulateData(db);
  }

  Future<void> _onPrePopulateData(Database db) async {
    try {
      final setting = {
        'invoiceNo': 1,
        'orderNo': 1,
        'invoiceText': "INV",
      };
      final customer = {
        'code': "CASH",
        'firstName': "General",
        'lastName': "General",
        'phoneNumber': "",
        'imagePath': "",
        'dob': "",
        'date': "",
      };
      final payment = {
        'code': "CASH",
        'description': "CASH",
        'description_2': "ប្រាក់",
        'displayLang': "EN",
        'imagePath': "",
      };
      await db.insert(SettingModel.tableName, setting);
      await db.insert(PaymentMethodModel.tableName, payment);
      await db.insert(CustomerModel.tableName, customer);
    } on Exception {
      rethrow;
    }
  }

  init() async {
    await database;
    return _database != null;
  }
}
