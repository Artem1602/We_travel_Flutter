import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_travel/model/WeTravelModel.dart';

import 'LoginScreen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: "Account",
            tiles: [
              SettingsTile(
                title: "Change password",
                subtitle: "Tap to change",
                leading: Icon(Icons.assignment_outlined),
              ),
              SettingsTile(
                title: "Log out",
                leading: Icon(Icons.logout),
                onPressed: logOut,
              )
            ],
          )
        ],
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }

  logOut(BuildContext context) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    var userDataFile = File(weTravelModel.docsDir.path + "/userData");
    var userImgFile = File(weTravelModel.docsDir.path + "/profile_img");
    userDataFile.delete();
    userImgFile.delete();
    await sharedPrefs.remove("user_id").whenComplete(() {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()),(route)=>false);
    });
  }
}
