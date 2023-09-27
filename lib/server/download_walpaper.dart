import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class DownloadWalpaper {
  Future<File?> downloadWallpaper(String url) async {
    try {
      Directory dir = await getTemporaryDirectory();
      var response = await get(Uri.parse(url));
      var filePath = '${dir.path}/${DateTime.now().toIso8601String()}.jpg';
      File file = File(filePath);
      file.writeAsBytesSync(response.bodyBytes);
      print("downloaded");
      return file;
    } catch (e) {
      return null;
    }
  }
}

final imageDownload = Provider<DownloadWalpaper>((ref) {
  return DownloadWalpaper();
});
