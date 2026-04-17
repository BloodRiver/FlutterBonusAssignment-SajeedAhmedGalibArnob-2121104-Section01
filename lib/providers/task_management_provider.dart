import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/model_classes.dart';

class TaskManagementProvider with ChangeNotifier {
  final TaskRepository _repository = TaskRepository();
  Stream<List<Task>> get tasksStream => _repository.getTasksStream();

  void addTaskExternal({
    int? id,
    required String title,
    required String subtitle,
    required DateTime createdAt,
    IconData? icon,
  }) async {
    Task newTask = Task(title: title, description: subtitle, icon: icon);
    await _repository.addTask(newTask);
  }

  void deleteTaskExternal({required String id}) {
    _repository.deleteTask(id);
  }
}
