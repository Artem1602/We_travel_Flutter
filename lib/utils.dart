import 'dart:typed_data';

import 'package:logger/logger.dart';

final logger = Logger();

class VideoArguments{
  final String videoName;
  final Uint8List videoPreview;

  VideoArguments(this.videoName, this.videoPreview);
}