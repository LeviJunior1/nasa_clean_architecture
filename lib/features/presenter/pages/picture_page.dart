import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:nasa_clean_architecture/features/domain/entities/space_media.dart';
import 'package:nasa_clean_architecture/features/presenter/controllers/home_store.dart';
import 'package:nasa_clean_architecture/features/presenter/widget/custom_video_player.dart';
import 'package:nasa_clean_architecture/features/presenter/widget/description_bottom_sheet.dart';
import 'package:nasa_clean_architecture/features/presenter/widget/image_network_with_loader.dart';
import 'package:nasa_clean_architecture/features/presenter/widget/page_slider_up.dart';

class PicturePage extends StatefulWidget {
  late final DateTime? dateSelected;

  // ignore: prefer_const_constructors_in_immutables
  PicturePage({
    Key? key,
    this.dateSelected,
  }) : super(key: key);

  PicturePage.fromArgs(dynamic arguments, {super.key}) {
    dateSelected = arguments['dateSelected'];
  }

  static void navigate(DateTime? dateSelected) {
    Modular.to.pushNamed(
      '/picture',
      arguments: {'dateSelected': dateSelected},
    );
  }

  @override
  PicturePageState createState() => PicturePageState();
}

class PicturePageState extends ModularState<PicturePage, HomeStore> {
  @override
  void initState() {
    super.initState();
    store.getSpaceMediaFromDate(widget.dateSelected);
    print(widget.dateSelected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ScopedBuilder(
        store: store,
        onLoading: (context) =>
            const Center(child: CircularProgressIndicator()),
        onError: (context, error) => Center(
          child: Text(
            'An error occurred, try again later.',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.white),
          ),
        ),
        onState: (context, SpaceMediaEntity spaceMedia) {
          return PageSliderUp(
            onSlideUp: () => showDescriptionBottomSheet(
              context: context,
              title: spaceMedia.title,
              description: spaceMedia.description,
            ),
            child: spaceMedia.mediaType == 'video'
                ? CustomVideoPlayer(spaceMedia)
                : spaceMedia.mediaType == 'image'
                    ? ImageNetworkWithLoader(spaceMedia.mediaUrl)
                    : Container(),
          );
        },
      ),
    );
  }
}
