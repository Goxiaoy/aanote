import 'package:aanote/entity/enity_base.dart';
import 'package:moor/moor.dart';

class AuditedEntity extends EntityBase {
  DateTimeColumn get lastModificationTime => dateTime()();
  DateTimeColumn get creationTime => dateTime()();
}
