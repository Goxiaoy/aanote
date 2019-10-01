import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:aanote/utils/convert.dart';
part 'activity.g.dart';

enum ActivityStatus {
  //active status.
  Active,
  //archived, cannot add new item
  Archived,
}

@JsonSerializable()
class Activity {
  Activity({String id, @required this.name, @required this.startTime})
      : status = ActivityStatus.Active,
        isFavorite = false,
        id = id ?? Uuid().v4();
  String id;
  ActivityStatus status;

  String name;

  ///is favorite for user
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  bool isFavorite;

  ///latest set favorite time
  DateTime favoriteTime;

  DateTime startTime;
  DateTime endTime;

  String color;

  String desc;

  ///update favorite status
  setFavorite({bool value = true}) {
    if (isFavorite == value) {
      return;
    }
    isFavorite = value;
    if (isFavorite) {
      favoriteTime = DateTime.now();
    } else {
      favoriteTime = null;
    }
  }

  ///archive activity
  archive() {
    status = ActivityStatus.Archived;
    endTime = endTime ?? DateTime.now();
  }

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}


