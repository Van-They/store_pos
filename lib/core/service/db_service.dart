import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_pos/core/data/model/customer.dart';
import 'package:store_pos/core/data/model/payment_method_model.dart';

class DbService {
  DbService._();

  static Database? _database;

  static final DbService instance = DbService._();

  Future<Database> get database async {
    return _database ??= await initDatabase();
  }

  Future<Database> initDatabase() async {
    String externalPath = await getDatabasesPath();
    // String externalPath = await ExternalPath.getExternalStoragePublicDirectory(
    //     ExternalPath.DIRECTORY_DOCUMENTS);
    // String dir = join(externalPath, "store_data");
    // //create directory if folder not exit
    // File file = File(dir);
    // file.create(recursive: true);
    //create database
    String path = join(externalPath, 'store_database.db');
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

    //todo error
    // //pre data
    // _onPrePopulateData();
  }

  void _onPrePopulateData() async {
    try {
      final db = await database;

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
      final payResult = await db.insert(PaymentMethodModel.tableName, payment);
      final custResult = await db.insert(Customer.tableName, customer);
      print('pay======$payResult');
      print('cust======$custResult');
    } on Exception {
      rethrow;
    }
  }
}
