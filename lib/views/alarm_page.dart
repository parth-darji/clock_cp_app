import 'package:clock_cp_app/data.dart';
import 'package:clock_cp_app/main.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../constants/theme_data.dart';

class AlarmPage extends StatelessWidget {
  const AlarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 64,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Alarm",
            style: TextStyle(
              color: CustomColors.primaryTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              fontFamily: "avenir",
            ),
          ),
          Expanded(
            child: ListView(
              children: alarmItems
                  .map<Widget>(
                (alarm) => Container(
                  margin: EdgeInsets.only(
                    bottom: 32,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: alarm.gradientColors?.lastOrNull
                                ?.withOpacity(0.4) ??
                            Colors.transparent,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(4, 4),
                      )
                    ],
                    gradient: LinearGradient(
                      colors: alarm.gradientColors ?? [],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.label,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Office",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "avenir",
                                ),
                              ),
                            ],
                          ),
                          Switch(
                            value: true,
                            onChanged: (value) {},
                            activeColor: Colors.white,
                          ),
                        ],
                      ),
                      Text(
                        "Mon - Fri",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "avenir",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "07:00 AM",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "avenir",
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 36,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
                  .followedBy(
                [
                  DottedBorder(
                    radius: Radius.circular(24),
                    strokeWidth: 3,
                    color: CustomColors.clockOutline,
                    borderType: BorderType.RRect,
                    dashPattern: [5, 4],
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: CustomColors.clockBG,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextButton(
                        onPressed: () {
                          scheduleAlarm();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/add_alarm.png",
                              scale: 1.5,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Add Alarm",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "avenir",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void scheduleAlarm() async {
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;
    debugPrint(locations.length.toString()); // => 429
    for (var data in locations.keys) {
      debugPrint(data);
    }

    final detroit = tz.getLocation('Indian/Antananarivo');
    var scheduleNotificationDateTime = tz.TZDateTime.now(detroit).add(
      Duration(seconds: 10),
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      "alarm_notif",
      "alarm_notif",
      icon: "codex_logo",
      sound: RawResourceAndroidNotificationSound("a_long_cold_sting"),
      largeIcon: DrawableResourceAndroidBitmap("codex_logo"),
    );

    var iosPlatformChannelSpecifics = DarwinNotificationDetails(
      sound: "a_long_cold_sting.wav",
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      "Office",
      "Good morning! Time for Office",
      scheduleNotificationDateTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
}
