import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo_app/providers/auth_provider.dart';
import 'package:todo_demo_app/providers/task_provider.dart';
import 'package:todo_demo_app/screens/login_screen.dart';
import 'package:todo_demo_app/screens/task_list_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => TaskProvider())
    ],
    child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      home: Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if(auth.user == null) {
            return LoginScreen();
          }else {
            return const TaskListScreen();
          }
        },
      ),
    );
  }
}