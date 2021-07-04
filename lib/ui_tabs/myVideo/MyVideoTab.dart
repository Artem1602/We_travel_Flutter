import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
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

  void loadUserVideos(BuildContext context) async {
    var img = await VideoThumbnail.thumbnailData(
        video:
            "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        imageFormat: ImageFormat.JPEG,
        quality: 20);
    userVideoTabModel.addVideoListItem(buildListItem(
        "ONE",
        weTravelModel.userID!,
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        "10.02.2001",
        "313/59",
        img!,
        context));
    userVideoTabModel.addVideoListItem(buildListItem(
        "TWO",
        weTravelModel.userID!,
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        "10.02.2001",
        "313/59",
        img,
        context));

    var filesList =
        await FirebaseStorage.instance.ref(weTravelModel.userID).listAll();
    FullMetadata metadata;
    String downloadURL;
    Uint8List previewImg;

    for (var fileRef in filesList.items) {
      if (fileRef.name == "profile_img") continue;
      metadata = await fileRef.getMetadata();
      downloadURL = await fileRef.getDownloadURL();
      previewImg = (await VideoThumbnail.thumbnailData(
          video: downloadURL, imageFormat: ImageFormat.JPEG, quality: 20))!;
      userVideoTabModel.addVideoListItem(buildListItem(
          fileRef.name,
          metadata.customMetadata!["user_id"]!,
          downloadURL,
          metadata.customMetadata!["uploadingTime"]!,
          metadata.customMetadata!["position"]!,
          previewImg,
          context));
    }
  }

  Widget buildListItem(
    String videoName,
    String uID,
    String downloadURL,
    String uploadingTime,
    String position,
    Uint8List img,
    BuildContext context,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, AvailableRoutes().videoScreen,
              arguments: Video(
                  videoName, img, uID, downloadURL, uploadingTime, position));
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
