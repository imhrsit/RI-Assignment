part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

class LoadEmployees extends EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;
  AddEmployee(this.employee);
}

class DeleteEmployee extends EmployeeEvent {
  final Employee employee;
  DeleteEmployee(this.employee);
}

class UpdateEmployee extends EmployeeEvent {
  final Employee oldEmployee;
  final Employee newEmployee;
  
  UpdateEmployee({
    required this.oldEmployee,
    required this.newEmployee,
  });
}
