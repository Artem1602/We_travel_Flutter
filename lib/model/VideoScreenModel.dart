
import 'package:scoped_model/scoped_model.dart';
import 'package:we_travel/model/WeTravelModel.dart';

final VideoScreenModel videoScreenModel = VideoScreenModel(weTravelModel);

class VideoScreenModel extends Model{
  bool _playerIsInitialized = false;
  bool get playerIsInitialized => _playerIsInitialized;


  set playerIsInitialized(bool value) {
    _playerIsInitialized = value;
    notifyListeners();
  }

  WeTravelModel weTravelModel;

  VideoScreenModel(this.weTravelModel);
}