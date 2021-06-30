import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:we_travel/model/UserVideoTabModel.dart';
import 'package:we_travel/model/WeTravelModel.dart';

import '../../utils.dart';

class MyVideoTab extends StatelessWidget {
  final List<String> list = [];

  @override
  Widget build(BuildContext context) {
    loadUserVideos(context);
    return ScopedModel<UserVideoTabModel>(
        model: userVideoTabModel,
        child: ScopedModelDescendant(
          builder: (BuildContext inContext, Widget? inChild,
              UserVideoTabModel inModel) {
            return Expanded(
                child: ListView.builder(
              itemExtent: 100,
              itemCount: userVideoTabModel.userVideo.length,
              itemBuilder: (context, index) {
                return userVideoTabModel.userVideo[index];
              },
            ));
          },
        ));
  }

  void loadUserVideos(BuildContext context) {
    //TODO Test
    VideoThumbnail.thumbnailData(
            video:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
            imageFormat: ImageFormat.JPEG,
            quality: 20)
        .then((value) => {
              userVideoTabModel
                  .addVideoListItem(buildListItem("fileRef.name", value!, "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4" ,context))
            });
    VideoThumbnail.thumbnailData(
            video:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
            imageFormat: ImageFormat.JPEG,
            quality: 20)
        .then((value) =>
            {userVideoTabModel.addVideoListItem(buildListItem("assd", value!, "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",context))});

    // firebase_storage.FirebaseStorage.instance
    //     .ref(weTravelModel.userID)
    //     .listAll()
    //     .then((value) {
    //   for (var fileRef in value.items) {
    //     if (fileRef.name == "profile_img") continue;
    //     fileRef.getDownloadURL().asStream().listen((downloadURL) {
    //       VideoThumbnail.thumbnailData(
    //               video: downloadURL, imageFormat: ImageFormat.JPEG, quality: 20)
    //           .then((value) => userVideoTabModel
    //               .addVideoListItem(buildListItem(fileRef.name, value!,downloadURL,context)));
    //     });
    //   }
    // });
  }

  Widget buildListItem(String videoName, Uint8List img, String downloadURL, BuildContext context,) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context,AvailableRoutes().videoScreen,arguments: VideoArguments(videoName,img, weTravelModel.userID!,downloadURL));
        },
        child: Row(
          children: [
            Expanded(
              flex: 30,
              child: Column(
                children: [
                  Expanded(
                      child: Image.memory(
                    img,
                    fit: BoxFit.fill,
                  ))
                ],
              ),
            ),
            Expanded(
                flex: 70,
                child: Column(
                  children: [
                    Expanded(flex: 50, child: Center(child: Text(videoName))),
                    Expanded(flex: 50, child: Text("Info")),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
