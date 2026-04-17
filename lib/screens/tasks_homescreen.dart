import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/model_classes.dart';
import 'package:flutter_ui_class/providers/task_management_provider.dart';
import 'package:flutter_ui_class/screens/add_task_page.dart';
import 'package:flutter_ui_class/widgets/task_card_widget.dart';
import 'package:provider/provider.dart';

class TasksHomeScreen extends StatefulWidget {
  const TasksHomeScreen({super.key});

  @override
  State<TasksHomeScreen> createState() => _TasksHomeScreenState();
}

class _TasksHomeScreenState extends State<TasksHomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("Building Tasks Home Page...");

    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks Home"),
        backgroundColor: Colors.purpleAccent,
      ),

      body: Consumer<TaskManagementProvider>(
        builder: (context, taskProvider, _) {
          void handleTap(Task task) async {
            bool? result = await showDialog<bool>(
              context: context,
              builder: (buildContext) {
                return AlertDialog(
                  title: const Text("Confirm Action"),
                  content: Text(
                    "Are you sure you want to delete task: ${task.title}?",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => {Navigator.of(buildContext).pop(true)},
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => {Navigator.of(buildContext).pop(false)},
                      child: Text(
                        "No",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                );
              },
            );

            if (result == true) {
              taskProvider.deleteTaskExternal(id: task.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Task Deleted Successfully!"),
                ),
              );

              setState(() {});
            }
          }

          return StreamBuilder<List<Task>>(
            stream: taskProvider.tasksStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              final liveTasks = snapshot.data ?? [];

              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 190,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 5,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          Icon(Icons.task),
                          Text(
                            "Tasks Counter: ${liveTasks.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: liveTasks.length,
                        itemBuilder: (context, index) {
                          final task = liveTasks[index];
                          return TaskCardWidget(
                            task: task,
                            onTap: () => handleTap(task),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddTaskPage()));
        },
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add),
      ),
    );
  }
}
