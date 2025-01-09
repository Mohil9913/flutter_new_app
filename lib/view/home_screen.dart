import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/controller/language_controller.dart';
import 'package:new_app/controller/news_controller.dart';
import 'package:new_app/controller/theme_controller.dart';
import 'package:new_app/network/api_end_points.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final newsController = Get.find<NewsController>();
  final themeController = Get.find<ThemeController>();
  final languageController = Get.find<LanguageController>();

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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: newsController.fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No news available.'));
            }
            final newsList = snapshot.data!;
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                final news = newsList[index];
                final attachments = news['attachments'] as List<dynamic>;

                return InkWell(
                  onTap: () {
                    Get.toNamed('/open_news', arguments: news);
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text(news['headline'] ?? 'No Headline'),
                            subtitle: Text(
                                news['brief_description'] ?? 'No Description'),
                          ),
                          if (attachments.isNotEmpty) ...[
                            SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: attachments.map<Widget>((attachment) {
                                  final attachmentUrl =
                                      attachment['data']['url'];
                                  log('\n\nAttachment in HomeScreen: $attachment');
                                  if (attachmentUrl == null) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      color: Colors.black12,
                                      child: Icon(Icons.error, size: 40),
                                    );
                                  }

                                  final isImage =
                                      attachmentUrl.endsWith('.jpeg') ||
                                          attachmentUrl.endsWith('.jpg') ||
                                          attachmentUrl.endsWith('.png');
                                  final isVideo =
                                      attachmentUrl.endsWith('.mp4') ||
                                          attachmentUrl.endsWith('.mov');

                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: isImage
                                        ? Image.network(
                                            '$serverUrl/$attachmentUrl',
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                        : isVideo
                                            ? Container(
                                                height: 100,
                                                width: 100,
                                                color: Colors.black12,
                                                child: Icon(Icons.videocam,
                                                    size: 40),
                                              )
                                            : Container(
                                                height: 100,
                                                width: 100,
                                                color: Colors.black12,
                                                child: Icon(Icons.file_present,
                                                    size: 40),
                                              ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ),
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
