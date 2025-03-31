import 'dart:convert';

import 'package:todo_demo_app/models/task.dart';
import 'package:todo_demo_app/models/user.dart';
import 'package:http/http.dart' as http;
class ApiService {
  static const String baseUrl = 'http://localhost:1337/api';
  static String? jwt;


  // Login
  Future<User> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/local'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': email, 'password':password})
    );

    if(response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      jwt = user.jwt;
      return user;
    }else{
      throw Exception("Login Failed");
    }
  }

  // Fetch Tasks
  Future<List<Task>> fetchTasks() async {
    final response = await http.get(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Authorization': 'Bearer $jwt', 'Content-Type': 'application/json'},
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body)['data'] as List; 
      return data.map((task) => Task.fromJson(task)).toList();
    }else{
      throw Exception('Failed to load tasks');
    }
  }

  // Create Task
  Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Authorization': 'Bearer $jwt', 'Content-Type': 'application/json'},
      body: jsonEncode({'data': task.toJson()})
    );
    if(response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body)['data']);
    }else {
      throw Exception('Failed to create task');
    }
  }

  // Update Task
  Future<Task> updateTask(String id, Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {
        'Authorization': 'Bearer $jwt',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({'data': task.toJson()})
    );
    if(response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body)['data']);
    }else{
      throw Exception('Failed to update task');
    }
  }

  // Delete Task
  Future<void> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'),
    headers: {'Authorization': 'Bearer $jwt'});

    if(response.statusCode != 200){
      throw Exception('Failed to delete task');
    }
  }

}