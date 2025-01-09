import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenNews extends StatelessWidget {
  final news = Get.arguments;

  OpenNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news['headline'] ?? 'News Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
            if (news['NewsAttachmentMappings'] != null &&
                news['NewsAttachmentMappings'].isNotEmpty)
              Text(
                'Attachments:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (news['NewsAttachmentMappings'] != null)
              ...news['NewsAttachmentMappings'].map<Widget>((attachment) {
                return ListTile(
                  title: Text('Attachment ID: ${attachment['AttachmentId']}'),
                  subtitle: Text('Created at: ${attachment['createdAt']}'),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
