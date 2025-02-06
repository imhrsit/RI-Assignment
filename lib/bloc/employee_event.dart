part of 'employee_bloc.dart';

@immutable
sealed class EmployeeEvent {}

class AddEmployee extends EmployeeEvent {
  final Employee employee;
  AddEmployee(this.employee);
}

class DeleteEmployee extends EmployeeEvent {
  final Employee employee;
  DeleteEmployee(this.employee);
}
