import 'dart:async';

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:dio/dio.dart';

import 'objects/UserData.dart';
import 'objects/User.dart';

part 'RetrofitCore.g.dart';

@RestApi(baseUrl: "https://wetravel-1591a.firebaseio.com/")
abstract class FireBaseAPI {
  factory FireBaseAPI(Dio dio, {String baseUrl}) = _FireBaseAPI;

  static Dio _dio = Dio();
  static FireBaseAPI? fireBaseAPI;

  static FireBaseAPI? create(){
    if(fireBaseAPI == null) {
      fireBaseAPI = FireBaseAPI(_dio);
    }
    return fireBaseAPI;
  }

  //Users
  @GET("users.json")
  Future<Map<String,User>> getAllUsers();

  @GET("users/{id}.json")
  Future<User> getUser(@Path() String id);

  @PUT("users/{id}.json")
  Future<User> createNewUser(@Path() String id, @Body() User user);

  //User-data
  @GET("user_data.json")
  Future<Map<String,UserData>> getAllUserData();

  @GET("user_data/{id}.json")
  Future<UserData> getUserData(@Path() id);

  @PUT("user_data/{id}.json")
  Future<UserData> createNewUserData(@Path() String? id, @Body() UserData userData);
}
//TODO
//flutter pub run build_runner build