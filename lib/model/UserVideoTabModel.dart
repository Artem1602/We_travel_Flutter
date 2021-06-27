import 'package:flutter/cupertino.dart';
import 'package:we_travel/model/WeTravelModel.dart';

final UserVideoTabModel userVideoTabModel =
    new UserVideoTabModel(weTravelModel);

class UserVideoTabModel extends WeTravelModel {
  WeTravelModel weTravelModel;

  List<Widget> userVideo = [];

  UserVideoTabModel(this.weTravelModel);

  void addVideoListItem(Widget widget){
    userVideo.add(widget);
    notifyListeners();
  }
}
