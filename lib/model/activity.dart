import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';


part 'activity.g.dart';

enum ActivityStatus{
  //open status.
  Opening,
  //archived, cannot add new item
  Archived,
}

@JsonSerializable()

class Activity{
  Activity({@required this.name,@required this.startTime}):status=ActivityStatus.Opening;

  ActivityStatus status;

  String name;
  ///is favorite for user
  bool isFavorite;
  ///latest set favorite time
  DateTime favoriteTime;

  DateTime startTime;

  String desc;

  ///update favorite status
  setFavorite({bool value=true}){
    if(isFavorite==value){
      return;
    }
    isFavorite=value;
    if(isFavorite){
      favoriteTime=DateTime.now();
    }else{
      favoriteTime=null;
    }
  }

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}