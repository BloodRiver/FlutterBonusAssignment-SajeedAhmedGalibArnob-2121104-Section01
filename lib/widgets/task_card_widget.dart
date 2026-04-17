import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/model_classes.dart';

class TaskCardWidget extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;

  const TaskCardWidget({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      print("The card was tapped for ${task.title}: ${task.description}");
    }

    return Card(
      elevation: 1,
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(task.description),
        leading: task.icon != null ? Icon(task.icon) : Icon(Icons.task),
        trailing: IconButton(
          onPressed: onTap ?? handleTap,
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}
