import 'package:clock_cp_app/constants/enums.dart';
import 'package:flutter/material.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String? title;
  String? imageSource;

  MenuInfo(
    this.menuType, {
    this.title,
    this.imageSource,
  });

  void update(MenuInfo menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;
    notifyListeners();
  }
}
