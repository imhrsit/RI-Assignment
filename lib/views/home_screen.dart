import 'package:flutter/material.dart';
import 'package:realtime_innovations/global/colors.dart';
import 'package:realtime_innovations/views/add_employee_details.dart';
import 'package:realtime_innovations/models/employee.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static List<Employee> employees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List',
          style: TextStyle(
            color: kwhite,
          ),
        ),
        backgroundColor: kdarkBlue,
      ),
      body: employees.isEmpty
          ? Center(
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
            )
          : ListView(
              children: [
                _buildEmployeeSection('Current employees', 
                    employees.where((e) => !e.isFormer).toList()),
                _buildEmployeeSection('Previous employees', 
                    employees.where((e) => e.isFormer).toList()),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployeeDetails()),
          );
          if (result != null && result is Employee) {
            setState(() {
              employees.add(result);
            });
          }
        },
        backgroundColor: kdarkBlue,
        child: Icon(Icons.add, color: kwhite),
      ),
    );
  }

  Widget _buildEmployeeSection(String title, List<Employee> sectionEmployees) {
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
        ...sectionEmployees.map((employee) => _buildEmployeeCard(employee)),
      ],
    );
  }

  Widget _buildEmployeeCard(Employee employee) {
    String dateRange = "${_formatDate(employee.startDate)}";
    if (employee.endDate != null) {
      dateRange += " - ${_formatDate(employee.endDate!)}";
    }

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          employees.remove(employee);
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                employee.role,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                dateRange,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
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