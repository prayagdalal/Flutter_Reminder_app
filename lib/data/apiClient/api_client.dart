import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert' as convert;
import 'dart:io' as io;

class DBProvider {
  DBProvider._();
  static Database? _database;
  static const SECRET_KEY = "2021_PRIVATE_KEY_ENCRYPT_2021";

  List<String> tables = [];

  static final DBProvider db = DBProvider._();
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'reminderDB.db');
    //var db = await openDatabase(path, version: 1, onOpen: _onCreate);
    // return await openDatabase(path, version: 1, onOpen: onCreate);
    var db = await openDatabase(path, version: 1, onOpen: onCreate);
    return db;
  }

  onCreate(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS taskTbl (task_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,task_title TEXT,description TEXT,category_name TEXT,reminderType TEXT,isRepeat INTEGER DEFAULT 0,isSnoozed INTEGER DEFAULT 0,isActive INTEGER DEFAULT 0,isComplete INTEGER DEFAULT 0,frequency INTEGER,selected_days TEXT,custom_week INTEGER,custom_day INTEGER,custom_month int,custom_minute int,custom_hour int,time DATETIME,snooze_time INTEGER,updated_time DATETIME,isVibrated INTEGER DEFAULT 0)');
  }

  Future<List<TaskModel>> getTaskList() async {
    print('in');
    final db = await database;
    var res = await db.query("taskTbl");
    List<TaskModel> list =
        res.isNotEmpty ? res.map((c) => TaskModel.fromJson(c)).toList() : [];
    print(list.length);

    return list;
  }

  getdatabaselist() async {
    name = "";
    final db = await database;
    var res = await db.query("taskTbl");
    name = convert.json.encode(res);
    return name;
  }

  deleteTbl() async {
    final db = await database;

    // db.execute("DROP TABLE groupTbl");
    db.execute("DROP TABLE taskTbl");
  }

  getLastInsertedRowId() async {
    final db = await database;
    var id = await db.rawQuery(
        'SELECT *  FROM taskTbl WHERE task_id = (SELECT MAX(task_id) FROM taskTbl)');
    // print('in APIIII');
    // print('----------------');
    // print(id);
    return id;
  }

  addTask(TaskModel task) async {
    final db = await database;
    await db.insert('taskTbl', task.toJson());
  }

  deleteTask(int id) async {
    final db = await database;
    return db.delete("taskTbl", where: "task_id = ?", whereArgs: [id]);
  }

  updateTask(TaskModel taskObj) async {
    final db = await database;
    var res = db.update("taskTbl", taskObj.toJson(),
        where: "task_id=?", whereArgs: [taskObj.taskId]);
    return res;
  }

  Future<List<TaskModel>> getTaskByCat(String catNm) async {
    final db = await database;
    var res = await db
        .query("taskTbl", where: "category_name = ?", whereArgs: [catNm]);
    List<TaskModel> list =
        res.isNotEmpty ? res.map((c) => TaskModel.fromJson(c)).toList() : [];
    print(list.length);

    return list;
  }
}
