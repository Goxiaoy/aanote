import 'package:aanote/model/activity.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
class ActivityStatModel with ChangeNotifier {

  final Logger _log=Logger("ActivityStatModel");

  ///has any active activity
  bool get hasActive=>active.length>0;

  List<Activity> active=new List();

  String _currentActivityId;

  String get currentActivityId => _currentActivityId;


  Future<List<Activity>> loadActive () async{
    var items=await ActivityRepository().getActive();
    active=items;
    notifyListeners();
    return items;
  }

  init() async{
    _currentActivityId=await ActivityRepository().getCurrent();
    _log.info("current activity :$_currentActivityId");
    notifyListeners();
  }

  Future setCurrentActivity(Activity activity) async{
    await ActivityRepository().setCurrent(activity);
  }
}