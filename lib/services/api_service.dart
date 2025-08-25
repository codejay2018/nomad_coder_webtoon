import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://webtoon-crawler.nomadcoders.workers.dev';
  final String today = 'today';

  void getTodaysToons() async {
    final url = Uri.parse('$baseUrl/$today');
    debugPrint(url.toString());
    final res = await http.get(url);
    if (res.statusCode == 200) {
      debugPrint(res.body);
      return;
    } else {
      debugPrint(res.statusCode.toString());
      throw Error();
    }
  }
}
