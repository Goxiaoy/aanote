import 'package:aanote/entity/audited_entity.dart';
import 'package:moor/moor.dart';

part 'user.g.dart';

class User extends AuditedEntity {
  TextColumn get id => text().clientDefault(() => uuid.v4())();
  BoolColumn get isMe => boolean()();
  TextColumn get name => text().withLength(min: 1, max: maxNameLength)();
}
