// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'description': description,
      'isActive': isActive,
      'gradientColors': gradientColors?.map((x) => x.value).toList(),
    };
  }

  factory AlarmInfo.fromJson(Map<String, dynamic> map) {
    return AlarmInfo(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      description: map['description'] as String,
      isActive: map['isActive'] as bool,
      gradientColors: map['gradientColors'] != null
          ? List<Color>.from(
              (map['gradientColors'] as List<int>).map<Color?>(
                (x) => Color(x),
              ),
            )
          : null,
    );
  }
}
