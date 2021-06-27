import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/AccountModel.dart';
import 'package:we_travel/model/WeTravelModel.dart';
import 'package:we_travel/retrofit/RetrofitCore.dart';
import 'package:we_travel/retrofit/objects/UserData.dart';
import 'package:we_travel/utils.dart';
import '../../utils.dart';
import 'EditProfilePage.dart';
import 'ProfilePage.dart';

class AccountTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    fillUserData();
    return ScopedModel<AccountModel>(
      model: accountModel,
      child: ScopedModelDescendant(builder:
          (BuildContext inContext, Widget inChild, AccountModel inModel) {
        return WillPopScope(
            child: IndexedStack(
              index: accountModel.stackIndex,
              children: [ProfilePage(), EditProfilePage()],
            ),
            onWillPop: () async{
              if(accountModel.stackIndex == 1){
                accountModel.setStackIndex(0);
                return false;
              }else{
                return true;
              }
            });
      }),
    );
  }

  void fillUserData() async {
    if(accountModel.userImg is CircleAvatar){
      return;
    }
    await Firebase.initializeApp();
    var userDataFile = File(weTravelModel.docsDir.path + "/userData");
    var userImg = File(weTravelModel.docsDir.path + "/profile_img");
    userDataFile.exists().then(
        (userDataExist) => loadOrSetUserData(userDataExist, userDataFile));
    userImg.exists().then((imgExist) => loadOrSerUserImg(imgExist, userImg));
  }

  loadOrSetUserData(bool userDataExist, File userDataFile) async {
    logger.i("userData " + userDataExist.toString());
    if (userDataExist) {
      String allUserData = await userDataFile.readAsString();
      List dataParts = allUserData.split("|=====|");
      accountModel.initData(dataParts[0], dataParts[1], dataParts[2]);
    } else {
      UserData userData =
          await FireBaseAPI.create().getUserData(weTravelModel.userID);
      accountModel.initData(
          userData.userName, userData.status, userData.userInfo);
      userDataFile.writeAsString(userData.userName +
          "|=====|" +
          userData.status +
          "|=====|" +
          userData.userInfo);
    }
  }

  loadOrSerUserImg(bool imgExist, File userImg) async {
    logger.i("userImg " + imgExist.toString());
    if (imgExist) {
      File userImg = File(weTravelModel.docsDir.path + "/profile_img");
      accountModel.setUserImg(
          CircleAvatar(
        backgroundImage: Image.file(userImg).image,
        radius: 45,
      ));
    } else {
      String imgUrl = await firebase_storage.FirebaseStorage.instance
          .ref(weTravelModel.userID)
          .child("profile_img")
          .getDownloadURL();
      final http.Response responseData = await http.get(imgUrl);
      var byteList = responseData.bodyBytes;
      var buffer = byteList.buffer;
      File userImg = await File(weTravelModel.docsDir.path + "/profile_img")
          .writeAsBytes(buffer.asInt8List(
              byteList.offsetInBytes, byteList.lengthInBytes));
      accountModel.setUserImg(CircleAvatar(
        backgroundImage: Image.file(userImg).image,
        radius: 45,
      ));
    }
  }

}
