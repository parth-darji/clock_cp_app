import 'package:clock_cp_app/enums.dart';
import 'package:clock_cp_app/models/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/home_page.dart';

class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<MenuInfo>(
        create: (BuildContext context) => MenuInfo(
          MenuType.clock,
        ),
        child: HomePage(),
      ),
    );
  }
}
