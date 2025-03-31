import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo_app/providers/auth_provider.dart';
import 'package:todo_demo_app/providers/task_provider.dart';
import 'package:todo_demo_app/screens/task_edit_screen.dart';

class TaskListScreen extends StatelessWidget {

  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    return Scaffold(appBar: AppBar(
      title: const Text('Tasks'),
      actions: [
        IconButton(onPressed: () {
          Provider.of<AuthProvider>(context, listen: false ).logout();
        }, icon: const Icon(Icons.logout))
      ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, _) {
          if(provider.tasks.isEmpty){
            taskProvider.fetchTasks;
            return const Center(child: CircularProgressIndicator(),);
          }
          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description ?? ''),
                trailing: IconButton(
                  icon: const Icon(Icons.delete), onPressed: () { 
                    taskProvider.deleteTask(task.id);
                   },
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskEditScreen(task: task)
                  )
                ),
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context, 
          MaterialPageRoute(builder: (_) => TaskEditScreen())
        ),
        child: const Icon(Icons.add),
      ),
    
    );
  }
}