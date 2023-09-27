import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walpapers/server/download_walpaper.dart';

final downloadPhotos = FutureProvider((ref) async {
  var download = ref.watch(photoUrl);
  return await ref.watch(imageDownload).downloadWallpaper(download);
});
final photoUrl = StateProvider<String>((ref) => "");
