// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityNote _$ActivityNoteFromJson(Map<String, dynamic> json) {
  return ActivityNote(
    json['id'] as String,
    json['name'] as String,
    json['categoryName'] as String,
  )..items = (json['items'] as List)
      ?.map((e) => e == null
          ? null
          : ActivityNoteItem.fromJson(e as Map<String, dynamic>))
      ?.toList();
}

Map<String, dynamic> _$ActivityNoteToJson(ActivityNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'name': instance.name,
      'items': instance.items,
    };
