import 'package:aanote/model/activity_note_item.dart';
import 'package:aanote/model/user.dart';
import 'package:flutter/cupertino.dart';

///link user to activity
class ActivityParticipation{

  String id;

  String activityId;

  ActivityParticipationType type;
  ///user Id
  String userId;

  User user;

  String poolName;

  String get displayName=>type==ActivityParticipationType.People?user?.name:poolName;

  List<ActivityNoteItem> linkedItems=new List();

  //money give out or should pay
  double money;

  ActivityParticipation.fromUser(String userId,{@required this.activityId}):type=ActivityParticipationType.People,userId=userId;
  ActivityParticipation.fromPool(String poolName,{@required this.activityId}):type=ActivityParticipationType.Pool,poolName=poolName;

}

enum ActivityParticipationType{
  ///people
  People,
  ///pool is a way to initial money in an activity
  Pool
}