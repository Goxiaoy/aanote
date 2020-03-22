import 'package:aanote/entity/audited_entity.dart';
import 'package:moor/moor.dart';

class Category extends AuditedEntity{

  TextColumn get id => text().clientDefault(() => uuid.v4())();
  TextColumn get name=>text().withLength(min:1,max:maxNameLength)();
  TextColumn get desc=>text().withLength(max:maxDescLength)();
  BoolColumn get isPreserved=>boolean().withDefault(const Constant(false))();

}