import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'list.dart';

class Databasehelper {
  static final _databasename = "resume.db";
  static final _databaseversion = 1;

  static final table = "resume_table";

  static final columnID = "id";
  static final columnName = "name";
  static final columnEmail = "email";
  static final columnMobile = "moblie";
  static final columnExperience = "experience";
  static final columnEducation = "education";
  static final columnProject = "project";

  Database? _database;

  Databasehelper._privateConstructor() {
    database;
  }

  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentdirecoty = await getApplicationDocumentsDirectory();
    String path = join(documentdirecoty.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $columnID INTEGER PRIMARY KEY,
      $columnName TEXT NOT NULL,
      $columnEmail TEXT NOT NULL,
      $columnMobile TEXT NOT NULL,
      $columnExperience TEXT NOT NULL,
      $columnEducation TEXT NOT NULL,
      $columnProject TEXT NOT NULL
    )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Item>> getTask() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> list = await db.rawQuery('SELECT * FROM $table');
    return list.map((countries) => Item.fromJson(countries)).toList();
  }

  Future<int> deleteList(int id) async {
    if (instance._database == null) {
      instance._database = await database;
    }

    Database db = instance._database!;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    print("deleteList");
    return res;
  }

  Future<int> update(int id, String name, String email, String moblie,
      String experience, String education, String project) async {
    Database db = await instance.database;
    var res = await db.update(
        table,
        {
          "name": name,
          "email": email,
          "moblie": moblie,
          "experience": experience,
          "education": education,
          "project": project,
        },
        where: "id =?",
        whereArgs: [id]);
    return res;
  }
}
