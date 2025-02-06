import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations/bloc/employee_bloc.dart';
import 'package:realtime_innovations/global/colors.dart';
import 'package:realtime_innovations/views/add_employee_details.dart';
import 'package:realtime_innovations/models/employee.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhite.withOpacity(0.9),
      appBar: AppBar(
        title: Text('Employee List',
          style: TextStyle(
            color: kwhite,
          ),
        ),
        backgroundColor: kdarkBlue,
      ),
      body: BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (context, state) {
          // Show empty state image for both initial and empty loaded states
          if (state is EmployeeInitial || (state is EmployeeLoaded && state.employees.isEmpty)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image.png',
                    height: 200,
                    width: 200,
                  ),
                ],
              ),
            );
          }
          
          if (state is EmployeeLoaded) {
            final employees = state.employees;
            return ListView(
              children: [
                _buildEmployeeSection('Current employees', 
                    employees.where((e) => !e.isFormer).toList(), context),
                _buildEmployeeSection('Previous employees', 
                    employees.where((e) => e.isFormer).toList(), context),
              ],
            );
          }
          
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployeeDetails()),
          );
          if (result != null && result is Employee) {
            context.read<EmployeeBloc>().add(AddEmployee(result));
          }
        },
        backgroundColor: kdarkBlue,
        child: Icon(Icons.add, color: kwhite),
      ),
    );
  }

  Widget _buildEmployeeSection(String title, List<Employee> sectionEmployees, BuildContext context) {
    if (sectionEmployees.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              color: kdarkBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...sectionEmployees.asMap().entries.map((entry) {
          final isLast = entry.key == sectionEmployees.length - 1;
          return Column(
            children: [
              _buildEmployeeCard(entry.value, context),
              if (!isLast) const Divider(height: 1, thickness: 1),
            ],
          );
        }),
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 16.0, top: 8.0),
          child: Text(
            'Swipe left to delete',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeCard(Employee employee, BuildContext context) {
    String dateRange = "${_formatDate(employee.startDate)}";
    if (employee.endDate != null) {
      dateRange += " - ${_formatDate(employee.endDate!)}";
    }
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: kred,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(Icons.delete_outline, color: kwhite),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        context.read<EmployeeBloc>().add(DeleteEmployee(employee));
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Employee data has been deleted'),
            action: SnackBarAction(
              label: 'Undo',
              textColor: kdarkBlue,
              onPressed: () {
                context.read<EmployeeBloc>().add(AddEmployee(employee));
              },
            ),
          ),
        );
      },
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEmployeeDetails(
                isEditing: true,
                employee: employee,
              ),
            ),
          );
          if (result != null) {
            if (result == 'delete') {
              context.read<EmployeeBloc>().add(DeleteEmployee(employee));
            } else if (result is Employee) {
              context.read<EmployeeBloc>().add(UpdateEmployee(
                oldEmployee: employee,
                newEmployee: result,
              ));
            }
          }
        },
        child: Container(
          width: double.infinity,
          color: kwhite,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  employee.role,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dateRange,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day} ${_getMonthName(date.month)}, ${date.year}";
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}