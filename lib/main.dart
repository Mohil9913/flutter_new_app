import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/bindings/initial_binding.dart';
import 'package:new_app/translator/app_translations.dart';
import 'package:new_app/view/home_screen.dart';
import 'package:new_app/view/open_news.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final isDarkMode = prefs.getBool('isDarkMode') ?? false;
  final locale = prefs.getString('locale') ?? 'en';

  runApp(MyApp(isDarkMode: isDarkMode, locale: locale));
}

class MyApp extends StatelessWidget {
  final bool isDarkMode;
  final String locale;

  const MyApp({super.key, required this.isDarkMode, required this.locale});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: Locale(locale),
      translations: AppTranslations(),
      initialBinding: InitialBinding(),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/open_news', page: () => OpenNews()),
      ],
    );
  }
}
