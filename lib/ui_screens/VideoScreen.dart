import 'package:flutter/cupertino.dart';
import 'package:we_travel/utils.dart';

//TODO example: https://www.youtube.com/watch?v=umhl2hakkcY
class VideoScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as VideoArguments?;

    return Container(
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          Column(
            children: [],
          )
        ],
      ),
    );
  }

}