import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/user_list/user_list_bloc.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (context) => UserListBloc(),
        child: const UserListScreen(),
      ),
    );
  }
}
