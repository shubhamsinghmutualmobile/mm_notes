import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _dbName = "mmNotesDb.db";
  static const _dbVersion = 1;
  static const _tableName = "notes_table";
  static const _trashTableName = "trash_notes_table";
  static const columnId = "id";
  static const columnTitle = "title";
  static const columnBody = "body";
  static const columnDateCreated = "dateCreated";
  static const columnNoteColor = "noteColor";
  static const columnIsPinned = "isPinned";

  // Making it a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initiateDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName 
      (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnTitle TEXT NOT NULL, 
      $columnBody TEXT NOT NULL, 
      $columnDateCreated INTEGER NOT NULL,
      $columnNoteColor TEXT NOT NULL,
      $columnIsPinned BOOLEAN NOT NULL
      );
      ''');
    await db.execute('''
      CREATE TABLE $_trashTableName 
      (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $columnTitle TEXT NOT NULL, 
      $columnBody TEXT NOT NULL, 
      $columnDateCreated INTEGER NOT NULL,
      $columnNoteColor TEXT NOT NULL,
      $columnIsPinned BOOLEAN NOT NULL
      );
      ''');
  }

  // Returns the id of the new item created
  Future<int?> insert(Map<String, dynamic> row, {bool isTrashTable = false}) async {
    Database? db = await instance.database;
    if (db != null) {
      if(isTrashTable) {
        return await db.insert(_trashTableName, row);
      } else {
        return await db.insert(_tableName, row);
      }
    }
  }

  Future<List<Map<String, dynamic>>?> queryAll({bool isTrashTable = false}) async {
    Database? db = await instance.database;
    if (db != null) {
      if(isTrashTable) {
        return await db.query(_trashTableName);
      } else {
        return await db.query(_tableName);
      }
    }
  }

  // Returns number of rows updated
  Future<int?> update(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    if (db != null) {
      return await db
          .update(_tableName, row, where: '$columnId = ?', whereArgs: [id]);
    }
  }

  Future<int?> delete(int id, {bool isTrashTable = false}) async {
    Database? db = await instance.database;
    if (db != null) {
      if(isTrashTable) {
        return await db
            .delete(_trashTableName, where: '$columnId = ?', whereArgs: [id]);
      } else {
        return await db
            .delete(_tableName, where: '$columnId = ?', whereArgs: [id]);
      }
    }
  }

  Future<int?> emptyTrash() async {
    Database? db = await instance.database;
    if (db != null) {
      db.delete(_trashTableName, where: null);
    }
  }
}
