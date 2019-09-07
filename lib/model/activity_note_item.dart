import 'package:json_annotation/json_annotation.dart';


part 'activity_note_item.g.dart';


@JsonSerializable()

class ActivityNoteItem{
  ActivityNoteItem(this.id,this.name,this.activityNodeId);

  String id;
  ///self name
  String name;

  String activityNodeId;


  factory ActivityNoteItem.fromJson(Map<String, dynamic> json) => _$ActivityNoteItemFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityNoteItemToJson(this);
}