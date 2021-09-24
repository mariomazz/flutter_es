import 'dart:async';
import 'package:floor/floor.dart';
import 'package:todolist/src/dao/todo_dao.dart';
import 'package:todolist/src/model/todo.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:path/path.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [Todo])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
