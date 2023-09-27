import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:walpapers/constants/color_const.dart';
import 'package:walpapers/controller/search_controller.dart';
import 'package:walpapers/controller/walpaper_controller.dart';
import 'package:walpapers/view/screens/details_screen.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(getPhotos);

    TextEditingController controller = TextEditingController();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 90),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Walpapers",
                    style: TextStyle(fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15, bottom: 15),
                    child: Neumorphic(
                      child: TextField(
                        onChanged: (value) {},
                        controller: controller,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            suffixIcon: ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(queryProvider.notifier)
                                      .update((state) => controller.text);
                                },
                                child: const Icon(CupertinoIcons.search)),
                            hintText: "Search Walpaper....",
                            counterStyle:
                                TextStyle(fontSize: 15, color: AppColor.grey),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: images.when(
          data: (img) {
            return MasonryGridView.count(
              itemCount: img.length,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              crossAxisCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailsPage(
                              wallpaperModel: img[index],
                            )));
                  },
                  child: CachedNetworkImage(
                    imageUrl: img[index].thumbnail,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) =>
              Center(child: Text(stackTrace.toString())),
          loading: () => Center(
                child: Lottie.asset('images/loading.json'),
              )),
    );
  }
}
