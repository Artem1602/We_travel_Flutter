import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';
import 'package:we_travel/model/VideoScreenModel.dart';
import 'package:we_travel/utils.dart';

//TODO example: https://www.youtube.com/watch?v=umhl2hakkcY
//https://pub.dev/documentation/video_player/latest/
class VideoScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  late final VideoPlayerController _videoPlayerController;

  @override
  Widget build(BuildContext context) {
    logger.i("VideoScreen");
    final videoArgs = ModalRoute.of(context)!.settings.arguments as VideoArguments;
    _videoPlayerController = VideoPlayerController.network(videoArgs.getDownloadURL);
    //TODO
    _videoPlayerController.initialize().then((value) {
      videoScreenModel.playerIsInitialized = true;
    });
    return ScopedModel<VideoScreenModel>(
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
                      child: SafeArea(top: true, child: Column(
                        children: [
                          Container(
                            height: 220,
                            width: double.infinity,
                            child: Stack(
                                children: [
                                  videoScreenModel.playerIsInitialized ? VideoPlayer(_videoPlayerController) : Image.memory(videoArgs.videoPreview),
                                  IconButton(onPressed: (){_videoPlayerController.play();}, icon: Icon(Icons.play_arrow))
                                ],
                            ),
                          )
                        ],
                      )))
                ],
              ),
            ));
          },
        ));
  }
}
