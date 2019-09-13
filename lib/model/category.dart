import 'package:json_annotation/json_annotation.dart';


part 'category.g.dart';


@JsonSerializable()

class Category{

  Category(this.id,this.name);

  String id;
  ///display name
  String name;

  String desc;

  ///preserved will not locale name, cannot delete
  bool isPreserved;


  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);


}