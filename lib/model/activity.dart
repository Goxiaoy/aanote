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
  Activity({@required this.name}):status=ActivityStatus.Opening;

  ActivityStatus status;

  String name;

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}