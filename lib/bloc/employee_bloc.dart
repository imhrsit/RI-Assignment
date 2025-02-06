import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtime_innovations/models/employee.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  List<Employee> _employees = [];

  EmployeeBloc() : super(EmployeeInitial()) {
    on<AddEmployee>((event, emit) {
      _employees.add(event.employee);
      emit(EmployeeLoaded(_employees));
    });

    on<DeleteEmployee>((event, emit) {
      _employees.remove(event.employee);
      emit(EmployeeLoaded(_employees));
    });
  }
}
