import 'package:aanote/app_route.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/view_model/activity_stat_model.dart';
import 'package:flutter/material.dart';

import 'generated/i18n.dart';

class ActivityListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ActivityListPageState();
}

///activity detail page
class _ActivityListPageState extends State<ActivityListPage> {
  ///current page Index
  int _currentPageIndex = 0;

  ///per page count
  static const int _perPageCount = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          _buildActive(context),
          Divider(),
          _buildArchived(context),
        ],
      ),
    );
  }

  Widget _buildActive(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(S.of(context).active),
        Divider(),
        //ListView()
      ],
    );
  }

  Widget _buildArchived(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(S.of(context).archived),
        Divider(),
        //ListView()
      ],
    );
  }

  void onTap(BuildContext context,ActivityStatModel model,Activity activity) async{
    await model.setCurrentActivity(activity);
    Navigator.pushNamed(context, AppRoute.activityDetail,arguments: activity.id);
  }
}
