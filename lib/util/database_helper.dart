import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/timeEntry.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  final String tableTimeEntry = "TimeEntryTable";
  final String timeEntryId = "TimeEntryId";
  final String timeEntryDate = "TimeEntryDate";
  final String timeEntrySpan = "TimeEntrySpan";
  final String timeEntryTitle = "TimeEntryTitle";

  static Database _db;

  DatabaseHelper.internal();

  Future get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'times.db');

    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE TimeEntries(TimeID INTEGER PRIMARY KEY AUTOINCREMENT, TimeDate TEXT, TimeSpan REAL, TimeTitle TEXT)');
  }

  // await db.execute(join(
  //     'CREATE TABLE TimeEntries(TimeID INTEGER PRIMARY KEY AUTOINCREMENT, TimeDate TEXT, TimeSpan REAL, TimeTitle TEXT);',
  //     'CREATE TABLE Tags(TagID INTEGER PRIMARY KEY AUTOINCREMENT, TagName TEXT, TagColor TEXT);',
  //     'CREATE TABLE TimesTags(TimeTagID INTEGER PRIMARY KEY AUTOINCREMENT, TagID INTEGER, FOREIGN KEY(TagID) REFERENCES Tags(TagID), TimeID INTEGER, FOREIGN KEY(TimeID) REFERENCES Times(TimeID));'
  //     )
  //   );

  Future saveTime(TimeEntry timeEntry) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableTimeEntry, timeEntry.toMap());

    //    var result = await dbClient.rawInsert(
    //        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');

    return result;
  }

  Future getAllTimes() async {
    var dbClient = await db;
    var result = await dbClient.query(tableTimeEntry,
        columns: [timeEntryId, timeEntryDate, timeEntrySpan, timeEntryTitle]);

    //  var result = await dbClient.rawQuery('SELECT * FROM $tableNote');

    return result.toList();
  }

  Future getCount() async {
    var dbClient = await db;
    return Sqflite.firstIntValue(
        await dbClient.rawQuery('SELECT COUNT(*) FROM $tableTimeEntry'));
  }

  Future getTime(int id) async {
    var dbClient = await db;
    List result = await dbClient.query(tableTimeEntry,
        columns: [timeEntryId, timeEntryDate, timeEntrySpan, timeEntryTitle],
        where: '$timeEntryId = ?',
        whereArgs: [id]);

    //    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');

    if (result.length > 0) {
      return new TimeEntry.fromMap(result.first);
    }

    return null;
  }

  Future deleteTime(int id) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableTimeEntry, where: '$timeEntryId = ?', whereArgs: [id]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }

  Future updateTime(TimeEntry timeEntry) async {
    var dbClient = await db;
    return await dbClient.update(tableTimeEntry, timeEntry.toMap(),
        where: "$timeEntryId = ?", whereArgs: [timeEntry.timeEntryId]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
