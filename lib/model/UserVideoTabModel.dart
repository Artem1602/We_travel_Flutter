import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/WeTravelModel.dart';

final UserVideoTabModel userVideoTabModel = UserVideoTabModel(weTravelModel);

class UserVideoTabModel extends Model {
  WeTravelModel weTravelModel;

  List<Widget> userVideo = [];

  UserVideoTabModel(this.weTravelModel);

  void addVideoListItem(Widget widget){
    userVideo.add(widget);
    notifyListeners();
  }
}
