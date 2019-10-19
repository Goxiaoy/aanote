import 'package:aanote/model/activity.dart';
import 'package:aanote/model/activity_note.dart';
import 'package:aanote/model/dto/PagedDto.dart';
import 'package:aanote/repositpory/sqlite_repository_base.dart';
import 'package:flutter/foundation.dart';
import 'package:queries/collections.dart';
import 'package:queries/queries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:aanote/generated/i18n.dart';

final String table_activity = "activity";
const String currentActivityKey = "currentActivity";

class ActivityRepository extends SqliteRepositoryBase {
  ///get active activities
  Future<List<Activity>> getActive() async {
    return await db.then((db) async {
      var raw = await db.query(table_activity,
          where: 'status = ?',
          whereArgs: [describeEnum(ActivityStatus.Active)],
          orderBy: 'creationTime desc');
      return raw.map((p) => Activity.fromJson(p)).toList();
    });
  }

  Future<String> getCurrent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String currentActivity = prefs.getString(currentActivityKey);
    return currentActivity;
  }

  Future setCurrent(String activityId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(currentActivityKey, activityId);
  }

  Future<Activity> get(String id) async {
    return await db.then((db) async {
      var maps =
          await db.query(table_activity, where: 'id = ?', whereArgs: [id]);
      if (maps.length > 0) {
        return Activity.fromJson(maps.first);
      }
      return null;
    });
  }

  /// get number of start with name
  Future<int> _countStartWithName(String name) async {
    return await db.then((db) async {
      var ret = Sqflite.firstIntValue(await db.rawQuery(
          "select count(*) from $table_activity where name like '$name%'"));
      return ret;
    });
  }

  ///get default setting of activity
  Future<Activity> getDefault() async {
    var name = S.current.defaultActivityName;
    var count = await _countStartWithName(name);
    return Activity(name: name + (count == 0 ? '': (count).toString()));
  }

  ///get archived activities
  Future<PagedDto<Activity>> getArchived(
      {int pageIndex = 0, int pageCount = 7}) async {}

  ///get activity notes group by date. default take latest 7 days
  Future<PagedDto<IGrouping<DateTime, ActivityNote>>> getNotesGroupedByDate(
      {String activityId, int pageIndex = 0, int pageCount = 7}) async {
    await Future.delayed(Duration(milliseconds: 200));
    var activityId = "1";
    //group by time then order by time.date desc then paged
    var notes = <ActivityNote>[
      ActivityNote(
          id: "1",
          name: "Test Note 1",
          activityId: activityId,
          time: DateTime.now()),
      ActivityNote(
          id: "2",
          name: "Test Note 2",
          activityId: activityId,
          time: DateTime.now()),
      ActivityNote(
          id: "3",
          name: "Test Note",
          activityId: activityId,
          time: DateTime.now()),
      ActivityNote(
          id: "4",
          name: "Test Note",
          activityId: activityId,
          time: DateTime.now().add(Duration(days: -1))),
      ActivityNote(
          id: "5",
          name: "Test Note",
          activityId: activityId,
          time: DateTime.now().add(Duration(days: -2))),
      ActivityNote(
          id: "6",
          name: "Test Note",
          activityId: activityId,
          time: DateTime.now().add(Duration(days: -10))),
    ];

    var grouped = Collection(notes)
        .groupBy((p) => DateTime(p.time.year, p.time.month, p.time.day))
        .skip(pageIndex * pageCount)
        .take(pageCount)
        .toList();

    return PagedDto<IGrouping<DateTime, ActivityNote>>(
        items: grouped, totalCount: 6);
  }

  ///add activity
  Future<Activity> add(Activity activity) async {
    assert(activity != null);
    activity.creationTime=DateTime.now();
    return await db.then((db) async {
      await db.insert(table_activity, activity.toJson());
      return activity;
    });
  }

  Future<Activity> update(Activity activity) async{
    //todo update
    //todo update user info and participator info

    //todo update activity info
  }
}
