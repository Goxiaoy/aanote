// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as String,
    name: json['name'] as String,
    isMe: intToBool(json['isMe'] as int),
  )..lastModificationTime = json['lastModificationTime'] == null
      ? null
      : DateTime.parse(json['lastModificationTime'] as String);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'isMe': boolToInt(instance.isMe),
      'name': instance.name,
      'lastModificationTime': instance.lastModificationTime?.toIso8601String(),
    };
