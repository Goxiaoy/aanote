import 'package:aanote/entity/audited_entity.dart';
import 'package:moor/moor.dart';

enum ActivityParticipationType{
  ///people
  People,
  ///pool is a way to initial money in an activity
  Pool
}

class ActivityParticipator extends AuditedEntity{
  
  TextColumn get activityId=>text().customConstraint(constraint)

}