import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';


part 'user.g.dart';


@JsonSerializable()

class User{
  User(this.name,{@required this.id,this.isMe=false,this.phone, this.email});

  String id;
  bool isMe;
  ///display name
  String name;
  ///email
  String email;
  ///phone number
  String phone;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}