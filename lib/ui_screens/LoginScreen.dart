import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:we_travel/model/WeTravelModel.dart';
import 'package:we_travel/retrofit/RetrofitCore.dart';
import 'package:we_travel/retrofit/objects/User.dart';

Logger logger = Logger();

class LoginScreen extends StatelessWidget {
  final firebaseApi = FireBaseAPI.create();

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onRecoverPassword: recoverPassword,
      title: "WeTravel",
      onLogin: (loginData) {
        return login(loginData);
      },
      onSignup: signUp,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed("/HomeScreen");
      },
    );
  }

  //TODO Check password or email
  Future<String?> login(LoginData loginData) async {
    Map<String, User> users = await firebaseApi!.getAllUsers();
    for (User user in users.values) {
      if (user.email == loginData.name) {
        if (user.password == loginData.password) {
          String id = users.keys.firstWhere((element) =>
              users[element]!.password == loginData.password &&
              users[element]!.email == loginData.name);
          weTravelModel.userID = id;
          insertSharedPrefs(id);
          return null;
        } else {
          return Future(() => "Invalid password");
        }
      }
    }
    return Future(() => "Invalid mail");
  }

  //TODO onError
  Future<String?> signUp(LoginData loginData) async {
    var uId = Uuid().v4();
    await firebaseApi!.createNewUser(uId, User(loginData.name, loginData.password));
    insertSharedPrefs(uId);
    return null;
  }

  Future insertSharedPrefs(String uId) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString("user_id", uId);
  }

  Future<String?>? recoverPassword(String p1) {
  }
}
