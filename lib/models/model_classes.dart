import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Task {
  static final List<IconData> availableIcons = [
    Icons.abc_rounded,
    Icons.account_balance,
    Icons.add,
    Icons.access_alarm,
    Icons.ac_unit,
  ];

  String? id;
  String title;
  String description;
  DateTime? createdAt = DateTime.now();
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
        icon = availableIcons[json['icon']];
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
    "createdAt": createdAt?.toIso8601String(),
    "icon": (icon == null) ? -1 : availableIcons.indexOf(icon!),
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

  Stream<List<Task>> getTasksStream() {
    return _db.collection(collectionName).snapshots().map((
      QuerySnapshot snapshot,
    ) {
      return snapshot.docs.map((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        return Task.fromMap(data, doc.id);
      }).toList();
    });
  }
}
