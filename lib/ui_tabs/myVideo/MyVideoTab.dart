import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_travel/model/WeTravelModel.dart';
import 'package:we_travel/retrofit/RetrofitCore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:we_travel/utils.dart';

class MyVideoTab extends StatelessWidget{
  final List<String> list = ["a","b","c","d"];
  @override
  Widget build(BuildContext context) {
    loadUserVideos();
    return Expanded(
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context,index){
          return ListTile(
            leading: Text("IMG"),
            title: Text("${list[index]}"),
          );
        },
      ),
    );
  }

  void loadUserVideos(){

    firebase_storage.FirebaseStorage.instance.ref(weTravelModel.userID).listAll().then((value){
      for(var fileRef in value.items){
        String ss = fileRef.name;
      }
    });
  }
}