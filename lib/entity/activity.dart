import 'package:aanote/entity/audited_entity.dart';
import 'package:aanote/entity/enum_converter.dart';
import 'package:moor/moor.dart';

enum ActivityStatus {
  //active status.
  Active,
  //archived, cannot add new item
  Archived,
}

class Activity extends AuditedEntity {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get name => text().withLength(min: 1, max: maxNameLength)();
  TextColumn get status=>text().map(const EnumConverter(ActivityStatus.values))();
  BoolColumn get isFavorite => boolean()();
  DateTimeColumn get favoriteTime => dateTime()();
  DateTimeColumn get endTime => dateTime()();
  IntColumn get color => integer()();
  TextColumn get desc => text().withLength(min: 0, max: maxDescLength)();



}
