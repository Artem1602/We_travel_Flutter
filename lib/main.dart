
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_travel/ui_screens/HomeScreen.dart';
import 'package:we_travel/ui_screens/LoginScreen.dart';
import 'package:we_travel/ui_screens/SettingsScreen.dart';

import 'model/WeTravelModel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  preLoadUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uId = preferences.getString("user_id");
    if (uId != null) {
      weTravelModel.userID = uId;
    }
    weTravelModel.docsDir = await getApplicationDocumentsDirectory();
    runApp(WeTravelApp());
  }
  preLoadUserID();
}

class WeTravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    weTravelModel.rootBuildContext = context;
    return MaterialApp(
        initialRoute: "/",
        routes: {
          "/HomeScreen": (screenContext) => HomeScreen(),
          "/LoginScreen": (screenContext) => LoginScreen(),
          "/SettingsScreen": (screenContext) => SettingsScreen(),
        },
        home: selectHome(context));
  }

  Widget selectHome(BuildContext inContext) {
    if (weTravelModel.userID != null) {
      return HomeScreen();
    }
    return LoginScreen();
  }
}
