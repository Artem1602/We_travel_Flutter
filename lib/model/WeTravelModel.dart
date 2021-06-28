import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

final WeTravelModel weTravelModel = new WeTravelModel();

class WeTravelModel extends Model {
  late BuildContext rootBuildContext;
  late Directory docsDir;
  String? userID;
  bool isHideAppBar = false;
  bool isKeyboardShow = false;

  void setIsHideAppBar(bool hideAppBar){
    isHideAppBar = hideAppBar;
    notifyListeners();
  }

  void setIsKeyboardShow(bool state){
    isKeyboardShow = state;
    notifyListeners();
  }

}
