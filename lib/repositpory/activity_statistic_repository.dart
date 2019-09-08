import 'package:aanote/model/activity.dart';
import 'package:aanote/model/statistics/activity_per_day_statistics.dart';
import 'package:aanote/model/statistics/activity_total_statistics.dart';
import 'package:aanote/model/user.dart';
import 'package:flutter/cupertino.dart';

///activity statistic
class ActivityStatisticsRepository{

  ///get total statistics
  Future<ActivityTotalStatistics> getTotal({@required String activityId,@required ActivityTotalStatisticsType type} ) async{
    //TODO
    return ActivityTotalStatistics()
        ..activityId=activityId..type=type..totalCost=100.0..averageDayCost=10.0;
  }

  Future<List<ActivityPerDayStatistics>> getPerDayStatistics({@required String activityId}) async{
      var activity=Activity(id:"1",name: "Test Ac1",startTime: DateTime.now().add(Duration(days: -200)));
      var users=[
        User("TestUser1",id: "1"),
        User("TestUser2",id: "2")
      ];
      var dates= [
      DateTime.now().add(Duration(days: -2)),
        DateTime.now().add(Duration(days: -1)),
      ];
      var ret=<ActivityPerDayStatistics>[];
      for (var user in users) {
        for(var date in dates){
          ret.add(ActivityPerDayStatistics(activity,date,100.0,user));
        }
      }
      return ret;
  }
}