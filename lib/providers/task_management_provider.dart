import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/card_data_model.dart';
import 'package:flutter_ui_class/models/model_classes.dart';

class TaskManagementProvider with ChangeNotifier {
  List<CardDataModel> dummy_tasks = [
    CardDataModel(title: "Task 1", subtitle: "This is the first task"),
    CardDataModel(
      title: "Task 2",
      subtitle: "This is the second task",
      icon: Icons.abc_rounded,
    ),
    CardDataModel(
      title: "Task 3",
      subtitle: "This is the third task",
      icon: Icons.account_balance,
    ),
    CardDataModel(
      title: "Task 4",
      subtitle: "This is the fourth task",
      icon: Icons.add,
    ),
    CardDataModel(
      title: "Task 5",
      subtitle: "This is the fifth task",
      icon: Icons.delete,
    ),
    CardDataModel(title: "Task 6", subtitle: "Custom TASK", icon: Icons.edit),
  ];

  late List<CardDataModel> tasks;

  final TaskRepository _repository = TaskRepository();

  void addTaskExternal({
    int? id,
    required String title,
    required String subtitle,
    required DateTime createdAt,
    IconData? icon,
  }) async {
    CardDataModel task = CardDataModel(
      title: title,
      subtitle: subtitle,
      icon: icon,
    );
    tasks.add(task);

    // Writing to Firebase
    Task newTask = Task(
      id: "",
      title: title,
      description: subtitle,
      createdAt: createdAt,
      icon: icon,
    );

    await _repository.addTask(newTask);

    notifyListeners();
  }

  TaskManagementProvider() {
    tasks = [];
    tasks.addAll(dummy_tasks);
    fetchTasksFromFirebase();
    notifyListeners();
  }

  Future<void> fetchTasksFromFirebase() async {
    List<Task> fetchedTasks = await _repository.getTasksOnce();

    for (Task eachTask in fetchedTasks) {
      tasks.add(
        CardDataModel(
          title: eachTask.title,
          subtitle: eachTask.description,
          icon: eachTask.icon,
        ),
      );
    }
    notifyListeners();
  }

  void printTaskCount() {
    print("Total tasks: ${tasks.length}");
  }

  void addTaskAuto() {
    tasks.add(
      CardDataModel(
        title: "Task ${tasks.length + 1}",
        subtitle: "This is task ${tasks.length + 1}",
        icon: Icons.auto_fix_normal,
      ),
    );

    print("Added Task ${tasks.length}");
    print(tasks.last);
    notifyListeners();
  }
}
