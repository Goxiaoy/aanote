// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['name'] as String,
    json['email'] as String,
    json['phone'] as String,
    isMe: json['isMe'] as bool,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'isMe': instance.isMe,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
    };
