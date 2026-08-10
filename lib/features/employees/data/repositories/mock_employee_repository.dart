import '../../domain/entities/employee.dart';
import '../../domain/repositories/employee_repository.dart';
import '../datasources/mock_employee_data.dart';

class MockEmployeeRepository implements EmployeeRepository {
  const MockEmployeeRepository();

  @override
  List<Employee> getEmployees() {
    return mockEmployees;
  }

  @override
  Employee? getEmployeeById(String id) {
    for (final employee in mockEmployees) {
      if (employee.id == id) {
        return employee;
      }
    }
    return null;
  }
}
