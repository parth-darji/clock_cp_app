import 'package:clock_cp_app/models/alarm_info.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tableAlarm = "alarm";
final String columnId = "id";
final String columnTitle = "title";
final String columnDateTime = "alarmDateTime";
final String columnPending = "isPending";
final String columnColorIndex = "gradientColorIndex";

class AlarmHelper {
  static Database? _database;
  static late AlarmHelper _alarmHelper;

  AlarmHelper._createInstance();

  factory AlarmHelper() {
    _alarmHelper = AlarmHelper._createInstance();
    return _alarmHelper;
  }

  Future<Database?> get database async {
    _database = await initializeDatabase();
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = "${dir}alarm.db";

    var db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableAlarm (
          $columnId integer primary key autoincrement,
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer)
        ''');
      },
    );

    return db;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await database;
    var result = await db?.insert(
      tableAlarm,
      alarmInfo.toJson(),
    );
    debugPrint("result: $result");
  }
}
