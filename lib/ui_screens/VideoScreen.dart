import 'package:flutter/cupertino.dart';

//TODO example: https://www.youtube.com/watch?v=umhl2hakkcY
class VideoScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [],
      ),
    );
  }

}