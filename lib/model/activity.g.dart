// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    name: json['name'] as String,
    startTime: json['startTime'] == null
        ? null
        : DateTime.parse(json['startTime'] as String),
  )
    ..status = _$enumDecodeNullable(_$ActivityStatusEnumMap, json['status'])
    ..isFavorite = json['isFavorite'] as bool
    ..favoriteTime = json['favoriteTime'] == null
        ? null
        : DateTime.parse(json['favoriteTime'] as String)
    ..desc = json['desc'] as String;
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'status': _$ActivityStatusEnumMap[instance.status],
      'name': instance.name,
      'isFavorite': instance.isFavorite,
      'favoriteTime': instance.favoriteTime?.toIso8601String(),
      'startTime': instance.startTime?.toIso8601String(),
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
  ActivityStatus.Opening: 'Opening',
  ActivityStatus.Archived: 'Archived',
};
