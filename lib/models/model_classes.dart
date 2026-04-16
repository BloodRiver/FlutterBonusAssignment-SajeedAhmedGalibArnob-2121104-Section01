import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_class/models/card_data_model.dart';

class Task {
  String? id;
  String title;
  String description;
  DateTime? createdAt;
  IconData? icon;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.createdAt,
    this.icon,
  });

  factory Task.fromMap(Map<String, dynamic> json, String documentId) {
    IconData icon = Icons.auto_fix_normal;

    if (json.containsKey('icon')) {
      if (json['icon'] != -1) {
        icon = CardDataModel.availableIcons[json['icon']];
      }
    }

    return Task(
      id: documentId,
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      createdAt:
          json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      icon: icon,
    );
  }

  Map<String, dynamic> toMap() => {
    "title": title,
    "description": description,
    "createdAt":
        createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
    "icon": (icon == null) ? -1 : CardDataModel.availableIcons.indexOf(icon!),
  };

  @override
  String toString() {
    return "<Task: id=$id, title=$title, description=$description, createdAt=${createdAt?.toIso8601String() ?? ''}>";
  }
}

class TaskRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionName = 'tasks';

  Future<void> addTask(Task task) async {
    try {
      await _db.collection(collectionName).add(task.toMap());
    } catch (e) {
      print("Error adding task: $e");
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _db.collection(collectionName).doc(id).delete();
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  Future<List<Task>> getTasksOnce() async {
    try {
      QuerySnapshot snapshot = await _db.collection(collectionName).get();

      return snapshot.docs.map((doc) {
        return Task.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      print("Error fetching tasks $e");
      return [];
    }
  }
}
