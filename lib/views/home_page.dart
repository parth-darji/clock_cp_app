import 'package:clock_cp_app/views/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    var timezoneString = now.timeZoneOffset.toString().split(".").first;
    var offsetSign = "";
    if (!timezoneString.startsWith("-")) {
      offsetSign = "+";
    }
    debugPrint("timezoneString: $timezoneString");
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMenuButton(
                  title: "Clock",
                  image: "assets/clock_icon.png",
                ),
                _buildMenuButton(
                  title: "Alarm",
                  image: "assets/alarm_icon.png",
                ),
                _buildMenuButton(
                  title: "Timer",
                  image: "assets/timer_icon.png",
                ),
                _buildMenuButton(
                  title: "Stopwatch",
                  image: "assets/stopwatch_icon.png",
                ),
              ],
            ),
          ),
          SafeArea(
            child: VerticalDivider(
              color: Colors.white24,
              width: 1,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 64,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: Text(
                      "Clock",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        fontFamily: "avenir",
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          formattedTime,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 64,
                            fontFamily: "avenir",
                          ),
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 20,
                            fontFamily: "avenir",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    fit: FlexFit.tight,
                    child: Align(
                      alignment: Alignment.center,
                      child: ClockView(size: 260),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Timezone",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            fontFamily: "avenir",
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: Colors.white,
                            ),
                            SizedBox(width: 16),
                            Text(
                              "UTC$offsetSign$timezoneString",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton({
    required String title,
    required String image,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
      ),
      onPressed: () {},
      child: Column(
        children: [
          Image.asset(
            image,
            scale: 1.5,
          ),
          SizedBox(height: 16),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "avenir",
            ),
          ),
        ],
      ),
    );
  }
}
