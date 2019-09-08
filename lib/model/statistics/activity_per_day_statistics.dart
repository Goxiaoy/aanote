import 'package:aanote/model/activity.dart';
import 'package:aanote/model/user.dart';

class ActivityPerDayStatistics{

  Activity activity;
  DateTime date;
  double cost;
  User user;

  ActivityPerDayStatistics(this.activity, this.date, this.cost, this.user);


}