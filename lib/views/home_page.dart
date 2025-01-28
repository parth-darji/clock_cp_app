import 'package:clock_cp_app/menu_info.dart';
import 'package:clock_cp_app/views/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../constants/theme_data.dart';
import '../data.dart';
import '../enums.dart';

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: menuItems
                .map(
                  (e) => _buildMenuButton(context, currentMenuInfo: e),
                )
                .toList(),
          ),
          SafeArea(
            child: VerticalDivider(
              color: Colors.white24,
              width: 1,
            ),
          ),
          Expanded(
            child: Consumer<MenuInfo>(
              builder: (context, MenuInfo value, child) {
                if (value.menuType != MenuType.clock) {
                  return SizedBox();
                }

                return Container(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required MenuInfo currentMenuInfo,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Consumer<MenuInfo>(
        builder: (BuildContext context, MenuInfo value, Widget? child) {
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: currentMenuInfo.menuType == value.menuType
                  ? CustomColors.menuBackgroundColor
                  : Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 8,
              ),
            ),
            onPressed: () {
              final menuInfo = Provider.of<MenuInfo>(context, listen: false);
              menuInfo.update(currentMenuInfo);
            },
            child: Column(
              children: [
                Image.asset(
                  currentMenuInfo.imageSource ?? "",
                  scale: 1.5,
                ),
                SizedBox(height: 16),
                Text(
                  currentMenuInfo.title ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "avenir",
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
