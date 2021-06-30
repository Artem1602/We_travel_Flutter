import 'dart:typed_data';

import 'package:logger/logger.dart';

final logger = Logger();

class AvailableRoutes {
  static final AvailableRoutes _availableRoutes = AvailableRoutes._internal();
  final String videoScreen = "/VideoScreen";
  final String settingsScreen = "/SettingsScreen";
  final String loginScreen = "/LoginScreen";
  final String homeScreen = "/HomeScreen";


  factory AvailableRoutes(){
    return _availableRoutes;
  }

  AvailableRoutes._internal();
}

class VideoArguments{
  final String videoName;
  final Uint8List videoPreview;
  final String uId;
  final String getDownloadURL;

  VideoArguments(this.videoName, this.videoPreview, this.uId, this.getDownloadURL);
}
