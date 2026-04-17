import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/model_classes.dart';
import 'package:flutter_ui_class/providers/task_management_provider.dart';
import 'package:flutter_ui_class/screens/add_task_page.dart';
import 'package:flutter_ui_class/widgets/task_card_widget.dart';
import 'package:provider/provider.dart';

class UiPage extends StatefulWidget {
  const UiPage({super.key});

  @override
  State<UiPage> createState() => _UiPageState();
}

class _UiPageState extends State<UiPage> {
  @override
  Widget build(BuildContext context) {
    print("Building UI Page...");

    return Scaffold(
      appBar: AppBar(
        title: Text("UI PAGE"),
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
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              final liveTasks = snapshot.data ?? [];

              return ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: liveTasks.length,
                itemBuilder: (context, index) {
                  final task = liveTasks[index];
                  return TaskCardWidget(
                    task: task,
                    onTap: () => handleTap(task),
                  );
                },
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
