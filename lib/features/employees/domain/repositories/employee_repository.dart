import '../entities/employee.dart';

abstract interface class EmployeeRepository {
  List<Employee> getEmployees();

  Employee? getEmployeeById(String id);
}
