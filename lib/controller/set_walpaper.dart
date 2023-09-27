import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:walpapers/constants/location_enum.dart';

class SetWalpaper {
  Future<void> setWallpaper(
      String wallpaperFile, WalpaperLocation location) async {
    try {
      if (location == WalpaperLocation.both) {
        await _setWallpaper(wallpaperFile, WalpaperLocation.home);
        await _setWallpaper(wallpaperFile, WalpaperLocation.lock);
      } else {
        await _setWallpaper(wallpaperFile, location);
      }
    } finally {
      _removeTemporaryFiles();
    }
  }

  void _removeTemporaryFiles() async {
    final Directory tempDir = await getTemporaryDirectory();
    tempDir.existsSync() ? tempDir.deleteSync(recursive: true) : null;
  }

  Future<void> _setWallpaper(String file, WalpaperLocation location) async {
    await AsyncWallpaper.setWallpaperFromFile(
      filePath: file,
      wallpaperLocation: location.value,
      goToHome: false,
    );
  }
}

var setMyWalpaper = Provider<SetWalpaper>((ref) => SetWalpaper());
