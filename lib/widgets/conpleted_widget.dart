import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/services/database_service.dart';
import '../model/task_model.dart';

class CompletedWidget extends StatefulWidget {
  const CompletedWidget({super.key});

  @override
  State<CompletedWidget> createState() => _CompletedWidgetState();
}

class _CompletedWidgetState extends State<CompletedWidget> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: _databaseService.completedtasks,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No Completed tasks yet.',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        List<Task> tasks = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            Task task = tasks[index];
            // final DateTime dt = task.timestamp.toDate();
            return Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Slidable(
                key: ValueKey(task.id),
                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: "Delete",
                        onPressed: (context){
                          _databaseService.deleteTask(task.id);
                        }),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                    decoration: TextDecoration.lineThrough),
                  ),
                  subtitle: Text(
                    task.description,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.lineThrough),
                  ),
                  // trailing: Text(
                  //   '${dt.day}/${dt.month}/${dt.year}',
                  //   style: const TextStyle(fontWeight: FontWeight.bold),
                  // ),
                ),
              ),
            );
          },
        );
      },
    );
  }
  void _showTaskDialog(BuildContext context, {Task? task}) {
    final TextEditingController _titleController = TextEditingController(text: task?.title);
    final TextEditingController _descriptionController = TextEditingController(text: task?.description);
    final DatabaseService _databaseServices = DatabaseService();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            task == null ? "Add Task" : "Edit Task",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: "Title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                if (task == null) {
                  await _databaseServices.addTaskItem(_titleController.text, _descriptionController.text);
                } else {
                  await _databaseServices.updateTask(task.id, _titleController.text, _descriptionController.text);
                }
                Navigator.pop(context);
              },
              child: Text(task == null ? "ADD" : "Update"),
            )
          ],
        );
      },
    );
  }
}
