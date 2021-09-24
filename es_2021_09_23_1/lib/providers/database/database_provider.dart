import 'package:es_2021_09_23_1/storage/database/dao/models/employee/employee_dao.dart';
import 'package:flutter/material.dart';

class DatabaseProvider extends ChangeNotifier {
  EmployeeDao? dao;

  EmployeeDao get getEmployeeDao => dao!;

  void setEmployeeDao(EmployeeDao dao_) {
    dao = dao_;
  }
}
