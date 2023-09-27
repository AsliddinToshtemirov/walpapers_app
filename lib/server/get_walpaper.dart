import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:walpapers/constants/api_key.dart';
import 'package:walpapers/model/walpapermodel.dart';

class ApiService {
  Future<List<WallpaperModel>> getWalpaper(String? query) async {
    List<WallpaperModel> list = [];
    final Response response = await get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=300"),
        headers: {'Authorization': ApiKey.apiKey});
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      data['photos'].forEach((element) {
        list.add(WallpaperModel.fromJson(element['src']));
      });
      return list;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});
