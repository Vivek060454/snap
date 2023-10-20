import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE iteme1(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        date TEXT,
        title TEXT,
        description TEXT,
        datetime TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }


  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtecuh1.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }


  static Future<int> createItem(

      String date,
      String title,
      String description,
      String datetime,
      ) async {
    final db = await SQLHelper.db();

    final data = {
      'date': date,
      'title': title,
      'description': description,
      'datetime': datetime,

    };
    final id = await db.insert('iteme1', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }


  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('iteme1', orderBy: "id");
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('iteme1', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete("iteme1", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}