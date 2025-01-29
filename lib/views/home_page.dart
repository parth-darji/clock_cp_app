import 'package:clock_cp_app/models/menu_info.dart';
import 'package:clock_cp_app/views/alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/theme_data.dart';
import '../data.dart';
import '../constants/enums.dart';
import 'clock_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                switch (value.menuType) {
                  case MenuType.clock:
                    return ClockPage();
                  case MenuType.alarm:
                    return AlarmPage();
                  default:
                    return SizedBox();
                }
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
