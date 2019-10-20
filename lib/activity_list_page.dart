import 'dart:ui';

import 'package:aanote/app_route.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/view_model/activity_stat_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'generated/i18n.dart';

class ActivityListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ActivityListPageState();
}

///activity detail page
class _ActivityListPageState extends State<ActivityListPage> {
  ///current page Index
  int _currentPageIndex = 0;

  List<Activity> _activeActivities;

  ///per page count
  static const int _perPageCount = 20;
  ActivityStatModel activityStatModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S.of(context).activity),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                //pop add activity page
                Navigator.of(context)
                    .pushNamed(AppRoute.activityEdit, arguments: null);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildActive(context),
          Divider(),
          _buildArchived(context),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final activityStatModel = Provider.of<ActivityStatModel>(context);
    if (activityStatModel != this.activityStatModel) {
      this.activityStatModel = activityStatModel;
      activityStatModel.loadActive();
    }
  }

  Widget _buildActive(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(S.of(context).active),
        Divider(),
        Consumer<ActivityStatModel>(
            builder: (context, activityStateModel, child) {
          var activities = activityStateModel.active;
          if (activities == null || activities.length == 0) {
            // add empty card
            return Card(
              child: Text(S.of(context).noActiveActivity),
            );
          } else {
            return Column(
              children: activities.map((f) {
                return _buildActivityCard(f);
              }).toList(),
            );
          }
        })
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

  Widget _buildActivityCard(Activity activity) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 85,
        child: InkWell(
          onTap: () => onTap(context, activity),
          child: Card(
            elevation: 10,
            color: Color(activity.color),
            margin: EdgeInsets.all(8),
            child: Text(activity.name),
          ),
        ));
  }

  void onTap(BuildContext context, Activity activity) async {
    Navigator.pushNamed(context, AppRoute.activityDetail,
        arguments: Tuple2<String, bool>(
            activity.id, activity.status == ActivityStatus.Active));
  }
}
