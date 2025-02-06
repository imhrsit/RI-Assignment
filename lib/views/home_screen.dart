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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image.png',  // Replace with your actual image path
              height: 200,  // Adjust size as needed
              width: 200,
            ),
          ],
        ),
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