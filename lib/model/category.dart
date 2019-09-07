import 'package:json_annotation/json_annotation.dart';


part 'category.g.dart';


@JsonSerializable()

class Category{
  Category(this.name);

  ///display name
  String name;


  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}