import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo_app/models/task.dart';
import 'package:todo_demo_app/providers/task_provider.dart';

class TaskEditScreen extends StatelessWidget {
  final Task? task;
  TaskEditScreen({super.key, this.task});
  // const TaskEditScreen({super.key});

final _titleController = TextEditingController();
final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(task!=null) {
      _titleController.text = task!.title;
      _descriptionController.text = task!.description ?? '';
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(task == null ? 'New Task' : 'Edit task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () async {
              final newTask = Task(
                id: task?.id ?? '',
                title: _titleController.text,
                description: _descriptionController.text,
                completed: task?.completed ?? false,
              );
              final provider = Provider.of<TaskProvider>(context, listen: false);
              if (task == null) {
                await provider.addTask(newTask);
              }else {
                await provider.updateTask(task!.id, newTask);
              }
            }
            , child: Text(task == null ? "Create" : "Update"))
        ],),
      ),
    );
  }
}