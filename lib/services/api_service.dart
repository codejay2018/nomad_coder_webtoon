import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

class ApiService {
  static const String baseUrl =
      'https://webtoon-crawler.nomadcoders.workers.dev';
  static const String today = 'today';

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> list = [];
    final url = Uri.parse('$baseUrl/$today');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(res.body);
      for (var webtoon in webtoons) {
        list.add(WebtoonModel.fromJson(webtoon));
      }
      return list;
    } else {
      throw Error();
    }
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final toon = jsonDecode(res.body);
      return WebtoonDetailModel.fromJson(toon);
    } else {
      throw Error();
    }
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpicodesById(
    String id,
  ) async {
    List<WebtoonEpisodeModel> list = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final res = await http.get(url);
    if (res.statusCode == 200) {
      final epicodes = jsonDecode(res.body);
      for (var epicode in epicodes) {
        list.add(WebtoonEpisodeModel(epicode));
      }
      return list;
    } else {
      throw Error();
    }
  }
}
