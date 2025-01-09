import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/language_controller.dart';
import 'package:new_app/controller/news_controller.dart';
import 'package:new_app/controller/theme_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final themeController = Get.find<ThemeController>();
  final languageController = Get.find<LanguageController>();
  final newsController = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('news app'.tr),
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
      body: RefreshIndicator(
        onRefresh: () async {
          await newsController.fetchNews();
        },
        child: FutureBuilder<List<dynamic>>(
          future: newsController.fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No news available.'.tr));
            }
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(news['headline'] ?? 'No headline'),
                    subtitle:
                        Text(news['brief_description'] ?? 'No description'),
                    onTap: () {
                      Get.toNamed('/open_news', arguments: news);
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
