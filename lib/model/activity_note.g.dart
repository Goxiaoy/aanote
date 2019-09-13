// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityNote _$ActivityNoteFromJson(Map<String, dynamic> json) {
  return ActivityNote(
    id: json['id'] as String,
    name: json['name'] as String,
    categoryId: json['categoryId'] as String,
    time: json['time'] == null ? null : DateTime.parse(json['time'] as String),
    activityId: json['activityId'] as String,
  )
    ..totalCost = (json['totalCost'] as num)?.toDouble()
    ..category = json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ActivityNoteToJson(ActivityNote instance) =>
    <String, dynamic>{
      'id': instance.id,
      'categoryId': instance.categoryId,
      'name': instance.name,
      'totalCost': instance.totalCost,
      'time': instance.time?.toIso8601String(),
      'category': instance.category,
      'activityId': instance.activityId,
    };
