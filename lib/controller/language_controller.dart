import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageController extends GetxController {
  var locale = 'en'.obs;

  void changeLanguage(String lang) async {
    locale.value = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', lang);
    Get.updateLocale(Locale(lang));
  }

  Widget bottomSheetLanguageSelector(BuildContext context) {
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
            title: Text('English'),
            onTap: () {
              changeLanguage('en');
              Get.back();
            },
          ),
          ListTile(
            title: Text('Hindi'),
            onTap: () {
              changeLanguage('hi');
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'hello': 'Hello',
          'Flutter Minimalist App': 'Flutter Minimalist App',
        },
        'hi': {
          'hello': 'नमस्कार', // Namaskar in Hindi
          'Flutter Minimalist App': 'फ्लटर मीनिमलिस्ट एप्प',
        },
      };
}
