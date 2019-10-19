import 'package:aanote/activity_list_page.dart';
import 'package:aanote/component/activity_card.dart';
import 'package:aanote/component/activity_edit.dart';
import 'package:aanote/initial_page.dart';
import 'package:aanote/model/activity.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class AppRoute {
  ///initial screen
  static const String initial = "initial";
  static const String activityList = "activityList";
  static const String activityDetail = "activityDetail";
  static const String activityEdit = "activityEdit";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (context) => InitialPage());
      case activityDetail:
        return MaterialPageRoute(builder: (context) {
          var arg = settings.arguments as Tuple2<String, bool>;
          return ActivityCard(
            activityId: arg.item1,
            updateCurrentActivity: arg.item2,
          );
        });
      case activityEdit:
        return MaterialPageRoute(
            builder: (context) =>
                ActivityEdit(activity: settings.arguments as Activity));
      case activityList:
        return MaterialPageRoute(builder: (context) => ActivityListPage());
      default:
        throw ArgumentError.value(settings.name);
    }
  }
}
