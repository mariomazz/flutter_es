import 'dart:async';
import 'package:es_2021_09_23_1/models/employee/employee.dart';
import 'package:es_2021_09_23_1/storage/database/dao/models/employee/employee_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Employee])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDAO;
}
