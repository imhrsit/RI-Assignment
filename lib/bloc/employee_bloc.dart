import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_innovations/models/employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  List<Employee> _employees = [];

  EmployeeBloc() : super(EmployeeInitial()) {
    on<LoadEmployees>((event, emit) async {
      await _loadEmployees();
      emit(EmployeeLoaded(List.from(_employees)));
    });

    on<AddEmployee>((event, emit) async {
      _employees.add(event.employee);
      await _saveEmployees();
      emit(EmployeeLoaded(List.from(_employees)));
    });

    on<DeleteEmployee>((event, emit) async {
      _employees.remove(event.employee);
      await _saveEmployees();
      emit(EmployeeLoaded(List.from(_employees)));
    });

    on<UpdateEmployee>((event, emit) async {
      final index = _employees.indexOf(event.oldEmployee);
      if (index != -1) {
        _employees[index] = event.newEmployee;
        await _saveEmployees();
        emit(EmployeeLoaded(List.from(_employees)));
      }
    });
  }

  Future<void> _loadEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final employeesJson = prefs.getString('employees');
    if (employeesJson != null) {
      final List<dynamic> jsonList = json.decode(employeesJson);
      _employees = jsonList.map((json) => Employee.fromJson(json)).toList();
    } else {
      _employees = [];
    }
  }

  Future<void> _saveEmployees() async {
    final prefs = await SharedPreferences.getInstance();
    final employeesJson = json.encode(_employees.map((e) => e.toJson()).toList());
    await prefs.setString('employees', employeesJson);
  }
}
