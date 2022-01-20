import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DBProvider {
  DBProvider._();
  static Database? _database;
  static final DBProvider db = DBProvider._();
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'reminderDB.db');
    //var db = await openDatabase(path, version: 1, onOpen: _onCreate);
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  Future onCreate(Database db, int dbversion) async {
    return await db.execute(
        'CREATE TABLE IF NOT EXISTS taskTbl (task_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,task_title TEXT,description TEXT,category_name TEXT,isMinute INTEGER DEFAULT 0,isHourly INTEGER DEFAULT 0, isDaily INTEGER DEFAULT 0,isWeekly INTEGER DEFAULT 0,isMonthly INTEGER DEFAULT 0,isYearly INTEGER DEFAULT 0,isCustom INTEGER DEFAULT 0,isRepeat INTEGER DEFAULT 0,isSnoozed INTEGER DEFAULT 0,isActive INTEGER DEFAULT 0,isComplete INTEGER DEFAULT 0,frequency INTEGER,selected_days TEXT,custom_week INTEGER,custom_day INTEGER,custom_month int,time DATETIME,snooze_time INTEGER,updated_time DATETIME,isVibrated INTEGER DEFAULT 0)');
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

  addTask(TaskModel task) async {
    final db = await database;
    await db.insert('taskTbl', task.toJson());
  }

  deleteTask(int id) async {
    final db = await database;
    return db.delete("taskTbl", where: "task_id = ?", whereArgs: [id]);
  }

  updateBatch(TaskModel taskObj) async {
    final db = await database;
    var res = db.update("taskTbl", taskObj.toJson(),
        where: "task_id=?", whereArgs: [taskObj.taskId]);
    return res;
  }
}
