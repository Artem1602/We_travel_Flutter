
import 'package:flick_video_player/flick_video_player.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';
import 'package:we_travel/model/WeTravelModel.dart';

final VideoScreenModel videoScreenModel = VideoScreenModel(weTravelModel);

class VideoScreenModel extends Model{

  VideoPlayerController? _videoPlayerController;
  FlickManager? _flickManager;

  FlickManager initFlickManager(String url) {
    if(_videoPlayerController != null){
      _videoPlayerController = null;
    }
    if(_flickManager != null){
      _flickManager = null;
    }
    _videoPlayerController = VideoPlayerController.network(url);
    _flickManager = FlickManager(videoPlayerController: _videoPlayerController!);
    return _flickManager!;
  }

  void makeNullVideoControllerFlickerManager() async {
    //TODO it is not OK. Think about normal dispose
    await _flickManager!.flickControlManager!.mute();
    // await _videoPlayerController!.dispose();
    // _flickManager = null;
    // _videoPlayerController = null;
  }



  WeTravelModel weTravelModel;

  VideoScreenModel(this.weTravelModel);
}