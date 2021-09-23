import 'package:es_2021_09_23_1/entity/entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class EmployeeDao {
  @Query('SELECT * FROM Employee')
  Stream<List<Employee>> getAllEmployee();

  @Query('SELECT * FROM Employee WHERE id=:id')
  Stream<List<Employee>> getAllEmployeebyId(int id);

  @Query('DELETE * FROM Employee')
  Stream<List<Employee>> deleteAllEmployee();

  @Query('DELETE * FROM Employee WHERE id=:id')
  Stream<List<Employee>> deleteEmployeeById(int id);

/*   @Query('INSERT * FROM Employee')
  Stream<List<Employee>> updateAllEmployee(List<Employee> employees);

  @Query('INSERT * FROM Employee WHERE id=:id')
  Stream<List<Employee>> insertEmployee(Employee employee); */

  @insert
  Future<void> insertEmployee(Employee employees);
  @update
  Future<void> updateEmployee(Employee employees);
  @delete
  Future<void> deleteEmployee(Employee employees);
}





/* CRUD : create, read-, update, delete- */

/* SQL CRUD : INSERT, SELECT, UPDATE, DELETE */
