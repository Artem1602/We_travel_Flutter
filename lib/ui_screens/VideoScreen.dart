import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/VideoScreenModel.dart';
import 'package:we_travel/utils.dart';

//TODO example: https://www.youtube.com/watch?v=umhl2hakkcY
//https://pub.dev/documentation/video_player/latest/
class VideoScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final videoArgs =
        ModalRoute.of(context)!.settings.arguments as VideoArguments;
    final FlickManager flickManager =
        videoScreenModel.initFlickManager(videoArgs.getDownloadURL);

    return WillPopScope(
      onWillPop: () async {
        videoScreenModel.makeNullVideoControllerFlickerManager();
        return true;
      },
      child: ScopedModel<VideoScreenModel>(
          model: videoScreenModel,
          child: ScopedModelDescendant(
            builder: (BuildContext inContext, Widget? inChild,
                VideoScreenModel videoScreenModel) {
              return Scaffold(
                  body: Container(
                child: CustomScrollView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  slivers: [
                    SliverToBoxAdapter(
                        child: SafeArea(
                            top: true,
                            child: Column(
                              children: [
                                Container(
                                  height: 220,
                                  width: double.infinity,
                                  child: FlickVideoPlayer(
                                    flickManager: flickManager,
                                    flickVideoWithControls:
                                        FlickVideoWithControls(
                                      controls: FlickPortraitControls(),
                                    ),
                                    flickVideoWithControlsFullscreen:
                                        FlickVideoWithControls(
                                      controls: FlickLandscapeControls(),
                                    ),
                                  ),
                                )
                              ],
                            )))
                  ],
                ),
              ));
            },
          )),
    );
  }
}
