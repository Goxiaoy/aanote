import 'package:aanote/model/activity.dart';

class ActivityRepository {
  ///get active activities
  Future<List<Activity>> getActive() async {
    var ret=<Activity>[
//      Activity(id:"1",name: "Test1 Activity", startTime: DateTime.now().add(Duration(days: -7))),
      Activity(
          id:"2",name: "Test2 Activity", startTime: DateTime.now().add(Duration(days: -3)))..setFavorite()];
//    ret.sort((a, b) => a.favoriteTime.compareTo(b.favoriteTime));
//    ret.sort((a, b) => int.parse(a.isFavorite.toString()));
    return ret;
  }
}
