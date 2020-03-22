import 'package:aanote/entity/activity.dart';
import 'package:aanote/entity/user.dart';
import 'package:aanote/entity/category.dart';
import 'package:moor/moor.dart';

@UseMoor(tables: [User,Category,Activity])
class NoteDatabase{

}