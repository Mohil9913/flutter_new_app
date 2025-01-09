import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_app/network/api_end_points.dart';

class NewsController extends GetxController {
  Future<List<dynamic>> fetchNews() async {
    final url = Uri.parse('$baseUrl$newsApi');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        return decodedData['data'];
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
