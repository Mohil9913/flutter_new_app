import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_app/network/api_end_points.dart';

class OpenNews extends StatelessWidget {
  final Map<String, dynamic> news = Get.arguments;

  OpenNews({super.key});

  @override
  Widget build(BuildContext context) {
    final attachments = news['attachments'] as List<dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(news['headline'] ?? 'News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                news['headline'] ?? 'No headline',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                news['publish_date'] != null
                    ? 'Published on: ${DateTime.parse(news['publish_date']).toLocal().toString().split(' ')[0]}'
                    : 'Publish date not available',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                news['long_description'] ?? 'No description available.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              if (attachments.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: attachments.length,
                  itemBuilder: (context, index) {
                    final attachment = attachments[index];
                    log('\n\nAttachment in OpenNews: $attachment');
                    final attachmentUrl = attachment['data']?['url'];

                    if (attachmentUrl == null) {
                      return Container(
                        color: Colors.black12,
                        child: Icon(Icons.error, size: 40),
                      );
                    }

                    final isImage = attachmentUrl.endsWith('.jpeg') ||
                        attachmentUrl.endsWith('.jpg') ||
                        attachmentUrl.endsWith('.png');
                    final isVideo = attachmentUrl.endsWith('.mp4') ||
                        attachmentUrl.endsWith('.mov');

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: isImage
                          ? Image.network(
                              '$serverUrl/$attachmentUrl',
                              fit: BoxFit.cover,
                            )
                          : isVideo
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.videocam, size: 40),
                                    Text('Video File'),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.file_present, size: 40),
                                    Text('Other File'),
                                  ],
                                ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
