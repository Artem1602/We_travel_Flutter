import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/VideoScreenModel.dart';
import 'package:we_travel/utils.dart';

class VideoScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final videoArgs = ModalRoute.of(context)!.settings.arguments as Video;
    videoScreenModel.initChewieController(videoArgs.getDownloadURL);

    return WillPopScope(
      onWillPop: () async {
        await videoScreenModel.dismissChewie();
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
                                SafeArea(
                                  top: true,
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: videoScreenModel.isPlayerInitFinished
                                        ? Chewie(
                                            controller: videoScreenModel
                                                .chewieController!,
                                          )
                                        : Image.memory(videoArgs.videoPreview),
                                  ),
                                ),
                                Text("data")
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
