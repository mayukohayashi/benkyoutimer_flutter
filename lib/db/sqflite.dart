import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

initDb() async {
  String databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'times.db');

  var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  return db;
}

void _onCreate(Database db, int newVersion) async {
  await db.execute(join(
      'CREATE TABLE TimeEntries(TimeID INTEGER PRIMARY KEY AUTOINCREMENT, TimeDate TEXT, TimeSpan REAL, TimeTitle TEXT);',
      'CREATE TABLE Tags(TagID INTEGER PRIMARY KEY AUTOINCREMENT, TagName TEXT, TagColor TEXT);',
      'CREATE TABLE TimesTags(TimeTagID INTEGER PRIMARY KEY AUTOINCREMENT, TagID INTEGER, FOREIGN KEY(TagID) REFERENCES Tags(TagID), TimeID INTEGER, FOREIGN KEY(TimeID) REFERENCES Times(TimeID));'));
}

Future saveTime(Time tag) async {
  var result = await db.insert(tableNote, note.toMap());

  return result;
}
