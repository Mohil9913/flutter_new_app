import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/network/api_end_points.dart';

class NewsController extends GetxController {
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final url = Uri.parse('$baseUrl$newsApi');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        List<dynamic> newsListData = decodedData['data'];

        List<Map<String, dynamic>> newsList = [];
        for (var newsData in newsListData) {
          // Add attachments directly to each news item
          List<Map<String, dynamic>> attachments =
              await fetchAttachments(newsData['NewsAttachmentMappings']);
          newsData['attachments'] = attachments;
          newsList.add(newsData);
        }

        return newsList;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> fetchAttachments(
      List<dynamic> attachmentMappings) async {
    List<Map<String, dynamic>> attachments = [];

    for (var mapping in attachmentMappings) {
      int? attachmentId = mapping['AttachmentId'];
      if (attachmentId == null) continue;

      final attachmentUrl = Uri.parse('$baseUrl$attachmentApi/$attachmentId');
      final response = await http.get(attachmentUrl);

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        attachments.add(decodedData);
      }
    }

    return attachments;
  }
}
