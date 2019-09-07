// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_note_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityNoteItem _$ActivityNoteItemFromJson(Map<String, dynamic> json) {
  return ActivityNoteItem(
    json['id'] as String,
    json['name'] as String,
    json['activityNodeId'] as String,
  );
}

Map<String, dynamic> _$ActivityNoteItemToJson(ActivityNoteItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'activityNodeId': instance.activityNodeId,
    };
