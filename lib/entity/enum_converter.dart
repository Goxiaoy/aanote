import 'package:moor/moor.dart';

T getEnumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value,
      orElse: () => null);
}

class EnumConverter<T> extends TypeConverter<T,String>{

  final Iterable<T> values;

  const EnumConverter(this.values);

  @override
  T mapToDart(String fromDb) {
    return getEnumFromString(values, fromDb);
  }

  @override
  String mapToSql(T value) {
    return value.toString();
  }


}

