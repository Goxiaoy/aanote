import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part 'activity_note_item.g.dart';


@JsonSerializable()

class ActivityNoteItem{
  ActivityNoteItem(String id,this.name,this.activityNodeId):id=id??Uuid().v4();

  String id;
  ///self name
  String name;

  String activityNodeId;


  factory ActivityNoteItem.fromJson(Map<String, dynamic> json) => _$ActivityNoteItemFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityNoteItemToJson(this);
}