import 'package:chewie/chewie.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:video_player/video_player.dart';
import 'package:we_travel/model/WeTravelModel.dart';

final VideoScreenModel videoScreenModel = VideoScreenModel(weTravelModel);

class VideoScreenModel extends Model {
  VideoScreenModel(this.weTravelModel);

  WeTravelModel weTravelModel;

  VideoPlayerController? _videoPlayerController;

  VideoPlayerController? get videoPlayerController => _videoPlayerController;

  ChewieController? _chewieController;

  ChewieController? get chewieController => _chewieController;

  bool isPlayerInitFinished = false;

  void initChewieController(String url) async {
    isPlayerInitFinished = false;
    _videoPlayerController = VideoPlayerController.network(url);
    await _videoPlayerController!.initialize().then((value) {
      isPlayerInitFinished = true;
      notifyListeners();
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
    );
  }

  //TODO don't think it's right, but it works. Try to fix it
  Future dismissChewie() async {
    await _videoPlayerController!.pause();
    // await _videoPlayerController!.dispose();
    // _chewieController!.dispose();
    notifyListeners();
  }
}
