import 'package:aanote/model/activity_note_item.dart';
import 'package:json_annotation/json_annotation.dart';


part 'activity_note.g.dart';


@JsonSerializable()

class ActivityNote{
  ActivityNote(this.id,this.name,this.categoryName);

  String id;
  ///category name
  String categoryName;
  ///self name
  String name;

  List<ActivityNoteItem> items;


  factory ActivityNote.fromJson(Map<String, dynamic> json) => _$ActivityNoteFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityNoteToJson(this);
}