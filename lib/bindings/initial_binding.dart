import 'package:get/get.dart';
import 'package:new_app/controller/language_controller.dart';
import 'package:new_app/controller/news_controller.dart';
import 'package:new_app/controller/theme_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ThemeController(), permanent: true);
    Get.put(LanguageController(), permanent: true);
    Get.put(NewsController(), permanent: true);
  }
}
