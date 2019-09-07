import 'package:aanote/model/activity.dart';

class ActivityRepository {
  ///get active activities
  Future<List<Activity>> getActive() async {
    var ret = new List<Activity>();

    var ac = new Activity(
        name: "Test1", startTime: DateTime.now().add(Duration(days: -7)));
    ret.add(ac);
    ac = new Activity(
        name: "Test2", startTime: DateTime.now().add(Duration(days: -3)));
    ac.setFavorite();
    ret.add(ac);
    //ret.sort((a, b) => a.favoriteTime.compareTo(b.favoriteTime));
    return ret;
  }
}
