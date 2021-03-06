// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    id: json['id'] as String,
    name: json['name'] as String,
  )
    ..status = _$enumDecodeNullable(_$ActivityStatusEnumMap, json['status'])
    ..isFavorite = intToBool(json['isFavorite'] as int)
    ..favoriteTime = json['favoriteTime'] == null
        ? null
        : DateTime.parse(json['favoriteTime'] as String)
    ..endTime = json['endTime'] == null
        ? null
        : DateTime.parse(json['endTime'] as String)
    ..creationTime = json['creationTime'] == null
        ? null
        : DateTime.parse(json['creationTime'] as String)
    ..lastModificationTime = json['lastModificationTime'] == null
        ? null
        : DateTime.parse(json['lastModificationTime'] as String)
    ..color = json['color'] as int
    ..desc = json['desc'] as String;
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'status': _$ActivityStatusEnumMap[instance.status],
      'name': instance.name,
      'isFavorite': boolToInt(instance.isFavorite),
      'favoriteTime': instance.favoriteTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'creationTime': instance.creationTime?.toIso8601String(),
      'lastModificationTime': instance.lastModificationTime?.toIso8601String(),
      'color': instance.color,
      'desc': instance.desc,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ActivityStatusEnumMap = {
  ActivityStatus.Active: 'Active',
  ActivityStatus.Archived: 'Archived',
};
