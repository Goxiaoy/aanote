import 'package:moor/moor.dart';
import 'package:uuid/uuid.dart';

class EntityBase extends Table{
  final uuid = Uuid();
  final int maxNameLength=1000;
  final int maxDescLength=10000; 

}