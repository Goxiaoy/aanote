import 'package:aanote/utils/convert.dart';
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';


part 'user.g.dart';


@JsonSerializable()

class User{
  User({String id,@required this.name,this.isMe=false}):id=id??Uuid().v4();

  String id;

  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  bool isMe;
  ///display name
  String name;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}