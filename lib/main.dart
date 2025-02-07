import 'package:flutter/material.dart';
import 'package:realtime_innovations/views/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations/bloc/employee_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = EmployeeBloc();
        bloc.add(LoadEmployees());
        return bloc;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Realtime Innovations',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}