import 'package:clock_cp_app/models/alarm_info.dart';
import 'package:clock_cp_app/models/menu_info.dart';

import 'constants/theme_data.dart';
import 'enums.dart';

List<MenuInfo> menuItems = [
  MenuInfo(
    MenuType.clock,
    title: "Clock",
    imageSource: "assets/clock_icon.png",
  ),
  MenuInfo(
    MenuType.alarm,
    title: "Alarm",
    imageSource: "assets/alarm_icon.png",
  ),
  MenuInfo(
    MenuType.timer,
    title: "Timer",
    imageSource: "assets/timer_icon.png",
  ),
  MenuInfo(
    MenuType.stopwatch,
    title: "Stopwatch",
    imageSource: "assets/stopwatch_icon.png",
  ),
];

List<AlarmInfo> alarmItems = [
  AlarmInfo(
    dateTime: DateTime.now().add(
      Duration(hours: 1),
    ),
    description: "Office",
    isActive: false,
    gradientColors: GradientColors.sky,
  ),
  AlarmInfo(
    dateTime: DateTime.now().add(
      Duration(hours: 2),
    ),
    description: "Sports",
    isActive: false,
    gradientColors: GradientColors.sunset,
  ),
];
