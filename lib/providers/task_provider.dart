import 'package:flutter/material.dart';
import 'package:todo_demo_app/models/task.dart';
import 'package:todo_demo_app/services/api_service.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  final ApiService _apiService = ApiService();
  List<Task> get tasks => _tasks;

  Future<void> fetchTasks(Task task) async {
    _tasks = await _apiService.fetchTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final newTask = await _apiService.createTask(task);
    _tasks.add(newTask);
    notifyListeners();
  }

  Future<void> updateTask(String id, Task task) async {
    final updatedTask = await _apiService.updateTask(id, task);
    final index = _tasks.indexWhere((t) => t.id == id);
    if(index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    await _apiService.deleteTask(id);
    _tasks.removeWhere((t) => t.id == id);
    notifyListeners();
  }
}