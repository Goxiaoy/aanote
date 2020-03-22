import 'package:aanote/model/activity.dart';
import 'package:aanote/entity/user.dart';

class ActivityPerDayStatistics{

  final Activity activity;
  final DateTime date;
  final double cost;
  final User user;

  ActivityPerDayStatistics(this.activity, this.date, this.cost, this.user);


}