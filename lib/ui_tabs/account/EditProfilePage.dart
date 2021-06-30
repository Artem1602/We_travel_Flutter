import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_travel/model/AccountModel.dart';
import 'package:we_travel/model/WeTravelModel.dart';
import 'package:we_travel/retrofit/RetrofitCore.dart';
import 'package:we_travel/retrofit/objects/UserData.dart';

class EditProfilePage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userStatusController = TextEditingController();
  final TextEditingController _userInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _userNameController.text = accountModel.userName;
    _userStatusController.text = accountModel.userStatus;
    _userInfoController.text = accountModel.userInfo;

    //TODO
    KeyboardVisibilityController().onChange.listen((event) {});

    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                showEditImgWidget(),
                Divider(),
                showForm(),
                showBtnRow()
              ],
            ),
          ),
        ),
      );
    });
  }

  showEditImgWidget() {
    return Flexible(
      flex: 0,
      child: Padding(
          padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
          child: Row(
            children: [
              SizedBox(width: 90, height: 90, child: accountModel.userImg),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Card(
                      child: OutlinedButton(
                        child: Text("Change photo"),
                        onPressed: changePhoto,
                      ),
                    )),
              )
            ],
          )),
    );
  }

  showBtnRow() {
    return Flexible(
      flex: 0,
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 10, right: 5),
            child: ElevatedButton(
                child: Text("Cancel"),
                onPressed: () => accountModel.setStackIndex(0)),
          )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 10, right: 5),
            child:
                ElevatedButton(child: Text("Save"), onPressed: saveEditedData),
          )),
        ],
      ),
    );
  }

  showForm() {
    return Flexible(
        flex: 1,
        child: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "User name",
                            hintText: accountModel.userName),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _userStatusController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "User status",
                            hintText: accountModel.userStatus),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      //TODO
                      Expanded(
                        child: TextField(
                          controller: _userInfoController,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            labelText: "User info",
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                          onChanged: (String val) {
                            val = "Empty";
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }

  void saveEditedData() async {
    if (_userNameController.text != accountModel.userName ||
        _userInfoController.text != accountModel.userInfo ||
        _userStatusController.text != accountModel.userStatus) {
      accountModel.initData(_userNameController.text,
          _userStatusController.text, _userInfoController.text);
      FireBaseAPI.create()!
          .createNewUserData(
              weTravelModel.userID,
              UserData(_userNameController.text, _userInfoController.text,
                  _userStatusController.text))
          .whenComplete(() => {accountModel.setStackIndex(0)});
      var userDataFile = File(weTravelModel.docsDir.path + "/userData");
      userDataFile.writeAsString(_userNameController.text +
          "|=====|" +
          _userStatusController.text +
          "|=====|" +
          _userInfoController.text);
    }
    accountModel.setStackIndex(0);
  }

  void changePhoto() async {
    Firebase.initializeApp();
    File newUserImg = File(await ImagePicker()
        .getImage(source: ImageSource.gallery)
        .then((value) => value!.path));
    accountModel.setUserImg(CircleAvatar(
      backgroundImage: Image.file(newUserImg).image,
      radius: 45,
    ));
    var compressedByteList = await FlutterImageCompress.compressWithList(
        newUserImg.readAsBytesSync(),
        quality: 50);
    var userImgFile = File(weTravelModel.docsDir.path + "/profile_img");
    await userImgFile.writeAsBytes(compressedByteList);
    firebase_storage.FirebaseStorage.instance
        .ref(weTravelModel.userID)
        .child("profile_img")
        .putData(compressedByteList);
  }
}
