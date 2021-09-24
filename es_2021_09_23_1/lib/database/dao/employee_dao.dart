import 'package:es_2021_09_23_1/database/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class EmployeeDao {
  @Query('SELECT * FROM Employee')
  Future<List<Employee>> getAllEmployee();

  @Query('SELECT * FROM Employee WHERE id=:id')
  Future<Employee?> getEmployeebyId(int id);

  @Query('DELETE FROM Employee')
  Future<void> deleteEmployee();

  @Query('DELETE FROM Employee WHERE id=:id')
  Future<void> deleteEmployeeById(int id);

  @insert
  Future<void> insertAllEmployee(List<Employee> todo);
  @insert
  Future<void> insertEmployee(Employee employee);
}

/* CRUD : create, read-, update, delete- */

/* SQL CRUD : INSERT, SELECT, UPDATE, DELETE */
