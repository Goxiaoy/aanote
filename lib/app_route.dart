import 'package:aanote/component/activity_card.dart';
import 'package:aanote/initial_page.dart';
import 'package:flutter/material.dart';

class AppRoute {
  ///initial screen
  static const String initial = "initial";
  static const String activityList = "activityList";
  static const String activityDetail = "activityDetail";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(builder: (context) => InitialPage());
      case activityDetail:
        return MaterialPageRoute(
            builder: (context) =>
                ActivityCard(activityId: settings.arguments as String));
      default:
        throw ArgumentError.value(settings.name);
    }
  }
}
