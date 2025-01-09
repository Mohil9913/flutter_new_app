import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/language_controller.dart';
import 'package:new_app/controller/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  final themeController = Get.find<ThemeController>();
  final languageController = Get.find<LanguageController>();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Get.bottomSheet(
                themeController.bottomSheetThemeSelector(context),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              Get.bottomSheet(
                languageController.bottomSheetLanguageSelector(context),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('hello'.tr),
      ),
    );
  }
}
