import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme(bool value) async {
    isDarkMode.value = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
  }

  Widget bottomSheetThemeSelector(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('Light'),
            onTap: () {
              toggleTheme(false);
              Get.back();
            },
          ),
          ListTile(
            title: Text('Dark'),
            onTap: () {
              toggleTheme(true);
              Get.back();
            },
          ),
          ListTile(
            title: Text('System'),
            onTap: () {
              final brightness =
                  View.of(context).platformDispatcher.platformBrightness;
              toggleTheme(brightness == Brightness.dark);
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
