import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:walpapers/constants/color_const.dart';
import 'package:walpapers/constants/location_enum.dart';
import 'package:walpapers/controller/set_walpaper.dart';
import 'package:walpapers/model/walpapermodel.dart';
import 'package:walpapers/server/download_walpaper.dart';
import 'package:walpapers/view/widgets/background.dart';

class DetailsPage extends ConsumerStatefulWidget {
  final WallpaperModel wallpaperModel;
  const DetailsPage({super.key, required this.wallpaperModel});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  File? wallpaperFile;
  @override
  void initState() {
    super.initState();

    ref
        .read(imageDownload)
        .downloadWallpaper(widget.wallpaperModel.original)
        .then((value) => setState(() => wallpaperFile = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
            child: Container(
              color: Colors.black.withOpacity(0.6),
            ),
          ),
        ),
        title: const Text(
          "Image",
          style: TextStyle(color: Colors.white),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Center(
        child: Stack(fit: StackFit.expand, children: [
          BackgroundImageFb1(
            imageUrl: widget.wallpaperModel.original,
            child: Container(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(color: AppColor.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        ref.read(setMyWalpaper).setWallpaper(
                            wallpaperFile!.path, WalpaperLocation.home);
                      },
                      child: const Text("Home screen")),
                  ElevatedButton(
                      onPressed: () {
                        ref.read(setMyWalpaper).setWallpaper(
                            wallpaperFile!.path, WalpaperLocation.both);
                      },
                      child: const Text("Both")),
                  ElevatedButton(
                      onPressed: () {
                        ref.read(setMyWalpaper).setWallpaper(
                            wallpaperFile!.path, WalpaperLocation.lock);
                      },
                      child: const Text("Lock Screen"))
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
