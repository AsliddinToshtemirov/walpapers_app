import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walpapers/controller/search_controller.dart';
import 'package:walpapers/model/walpapermodel.dart';

import '../server/get_walpaper.dart';

final getPhotos = FutureProvider<List<WallpaperModel>>((ref) {
  var query = ref.watch(queryProvider);
  return ref.watch(apiProvider).getWalpaper(query);
});
