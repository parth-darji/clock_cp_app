import 'package:flutter/material.dart';

class AlarmInfo {
  DateTime dateTime;
  String description;
  bool isActive;
  List<Color>? gradientColors;

  AlarmInfo({
    required this.dateTime,
    required this.description,
    required this.isActive,
    this.gradientColors,
  });
}
