import 'package:flutter/material.dart';
import 'package:realtime_innovations/global/colors.dart';
import 'package:realtime_innovations/views/add_employee_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: const Center(
        child: Text('No employee records found!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEmployeeDetails()),
          );
        },
        backgroundColor: kdarkBlue,
        child: Icon(Icons.add, color: kwhite),
      ),
    );
  }
}