import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/login_screen.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/provider/theme_provider.dart';
import 'package:task_manager/services/auth_service.dart';
import 'package:task_manager/services/database_service.dart';
import 'package:task_manager/widgets/conpleted_widget.dart';
import 'package:task_manager/widgets/pending_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _buttonIndex = 0;
  final _widgets = [
    // pending container
    const PendingWidget(),

    // completed container
    const CompletedWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      //backgroundColor: const Color(0xFF1d2630),
      appBar: AppBar(
        title: const Text("Task Manager "),
        actions: [
          IconButton(
            icon: Icon(themeProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
          IconButton(
            onPressed: () async {
              await AuthService().signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // pending inkwell
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _buttonIndex = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex == 0 ? Color(0xFF008891) : Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: _buttonIndex == 0 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color: _buttonIndex == 0 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
                // completed inkwell
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      _buttonIndex = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2.2,
                    decoration: BoxDecoration(
                      color: _buttonIndex == 1 ? Color(0xFF008891) : Colors.white70,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Completed",
                        style: TextStyle(
                          fontSize: _buttonIndex == 1 ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color: _buttonIndex == 1 ? Colors.white : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            _widgets[_buttonIndex]
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
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
              child: const Text("Cancel",style: TextStyle(color: Color(0xFF1E272E)),),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF008891),
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