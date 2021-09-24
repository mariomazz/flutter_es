import 'package:floor/floor.dart';

@entity
class Employee {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String firstName;
  final String lastName;
  final String email;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}
