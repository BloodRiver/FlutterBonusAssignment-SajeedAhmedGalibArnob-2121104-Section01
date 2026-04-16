import 'package:flutter/material.dart';

class CardDataModel {
  static final List<IconData> availableIcons = [
    Icons.abc_rounded,
    Icons.account_balance,
    Icons.add,
    Icons.access_alarm,
    Icons.ac_unit,
  ];
  final String title;
  final String subtitle;

  final IconData? icon;

  CardDataModel({required this.title, required this.subtitle, this.icon});

  @override
  String toString() {
    return "CardDataModel(title: $title, subtitle: $subtitle, icon: $icon)";
  }
}
