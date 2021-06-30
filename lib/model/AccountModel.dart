import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/WeTravelModel.dart';

final AccountModel accountModel = AccountModel(weTravelModel);

class AccountModel extends Model {
  final WeTravelModel weTravelModel;

  AccountModel(this.weTravelModel);

  Widget userImg = CircularProgressIndicator();
  String userName = "Enter your name";
  String userStatus = "Enter your status";
  String userInfo = "Enter your info";
  int stackIndex = 0;
  double fabOpacity = 1;

  void initData(String name, String status, String info) {
    userName = name;
    userStatus = status;
    userInfo = info;
    notifyListeners();
  }

  void cleanAllData() {
    userImg = CircularProgressIndicator();
    userName = "Enter your name";
    userStatus = "Enter your status";
    userInfo = "Enter your info";
    stackIndex = 0;
    fabOpacity = 1;
  }

  void setHideFab(double opacity) {
    fabOpacity = opacity;
    notifyListeners();
  }

  void setStackIndex(int index) {
    stackIndex = index;
    notifyListeners();
  }

  void setUserImg(Widget image) {
    userImg = image;
    notifyListeners();
  }

  void setUserName(String name) {
    userName = name;
    notifyListeners();
  }

  void setUserStatus(String status) {
    userStatus = status;
    notifyListeners();
  }

  void setUserInfo(String info) {
    userInfo = info;
    notifyListeners();
  }
}
