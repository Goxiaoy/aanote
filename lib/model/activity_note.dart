import 'package:aanote/model/activity_note_item.dart';
import 'package:aanote/model/activity_participation.dart';
import 'package:aanote/model/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part 'activity_note.g.dart';


@JsonSerializable()

class ActivityNote{
  ActivityNote({String id,this.name,this.categoryId,@required this.time,@required this.activityId}):id=id??Uuid().v4();

  String id;
  ///category name
  String categoryId;
  ///self name
  String name;

  ///total cost
  double totalCost;

  ///when did this note happen
  DateTime time;

  /// category property
  Category category;

  String activityId;

  @JsonKey(ignore: true)
  List<ActivityNoteItem> items=new List<ActivityNoteItem>();

  @JsonKey(ignore: true)
  List<ActivityParticipation> from=new List<ActivityParticipation>();

  @JsonKey(ignore: true)
  List<ActivityParticipation> to=new List<ActivityParticipation>();

  String get categoryName  =>category?.name;

  bool get shouldShowAdvanced=> items.length>0;

  factory ActivityNote.fromJson(Map<String, dynamic> json) => _$ActivityNoteFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityNoteToJson(this);
}