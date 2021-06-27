import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:we_travel/model/UserVideoTabModel.dart';
import 'package:we_travel/model/WeTravelModel.dart';

class MyVideoTab extends StatelessWidget {
  final List<String> list = [];

  @override
  Widget build(BuildContext context) {
    loadUserVideos();
    return ScopedModel<UserVideoTabModel>(
        model: userVideoTabModel,
        child: ScopedModelDescendant(
          builder: (BuildContext inContext, Widget inChild,
              UserVideoTabModel inModel) {
            return Expanded(
                child: ListView.builder(
                  itemExtent: 80,
              itemCount: userVideoTabModel.userVideo.length,
              itemBuilder: (context, index) {
                return userVideoTabModel.userVideo[index];
              },
            ));
          },
        ));
  }

  void loadUserVideos() {
    //TODO Test
    VideoThumbnail.thumbnailData(
            video:
                "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
            imageFormat: ImageFormat.JPEG,
            quality: 20)
        .then((value) => {
              userVideoTabModel
                  .addVideoListItem(buildListItem("fileRef.name", value))
            });

    // firebase_storage.FirebaseStorage.instance
    //     .ref(weTravelModel.userID)
    //     .listAll()
    //     .then((value) {
    //   for (var fileRef in value.items) {
    //     if (fileRef.name == "profile_img") continue;
    //     fileRef.getDownloadURL().asStream().listen((event) {
    //       VideoThumbnail.thumbnailData(
    //               video: event, imageFormat: ImageFormat.JPEG, quality: 20)
    //           .then((value) => userVideoTabModel
    //               .addVideoListItem(buildListItem(fileRef.name, value)));
    //     });
    //   }
    // });
  }

  Widget buildListItem(String videoName, Uint8List img) {
    return Card(
      child: InkWell(
        onTap: () {
          //TODO handle click
           },
        child: Row(
          children: [
            Expanded(
              flex: 30,
              child: Image.memory(img),
            ),
            Expanded(
                flex: 70,
                child: Column(
                  children: [
                    Expanded(flex: 50, child: Text(videoName)),
                    Expanded(flex: 50, child: Text("Info")),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}