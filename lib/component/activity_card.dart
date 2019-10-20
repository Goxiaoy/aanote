import 'package:aanote/app_route.dart';
import 'package:aanote/component/activity_note_list.dart';
import 'package:aanote/component/activity_statistics_view.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:shimmer/shimmer.dart';

class ActivityCard extends StatefulWidget {
  final double parallaxPercent;
  final String activityId;
  final bool updateCurrentActivity;

  ActivityCard(
      {@required this.activityId,
      this.parallaxPercent = 0.0,
      this.updateCurrentActivity = false});

  @override
  State<StatefulWidget> createState() {
    return _ActivityCardState();
  }
}

class _ActivityCardState extends State<ActivityCard>
    with TickerProviderStateMixin {
  Activity activity;
  List<Tab> _tabs;

  @override
  initState() {
    super.initState();
    if (widget.updateCurrentActivity) {
      //async set current activity id
      ActivityRepository().setCurrent(widget.activityId);
    }
    ActivityRepository().get(widget.activityId).then((p) {
      if (p == null) {
        _backToListPage();
      } else {
        setState(() {
          activity = p;
        });
      }
    });
    _tabs = <Tab>[
      Tab(
          child: ListTile(
        leading: Icon(Icons.pie_chart),
        title: Text("Info"),
      )),
      Tab(
          child: ListTile(
        leading: Icon(Icons.list),
        title: Text("Detail"),
      ))
    ];
  }

  Widget _buildActivityDes(Activity activity) {
    if (activity != null) {
      return Card(
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            if (activity.desc != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 5),
                child: new Text(
                  activity.desc,
                ),
              ),
            Row(
              children: <Widget>[
                new Text(
                  "StartTime: " +
                      new DateFormat('yyyy-MM-dd')
                          .format(activity.creationTime),
                ),
                if (activity.endTime != null)
                  new Text(
                    "EndTime: " +
                        new DateFormat('yyyy-MM-dd').format(activity.endTime),
                  )
              ],
            )
          ]));
    } else {
      return Shimmer.fromColors(
          child: Container(
            height: 50,
          ),
          baseColor: Colors.grey[400],
          highlightColor: Colors.white);
    }
  }

//  List<PopupMenuEntry> _buildPopupMenu() {
//    var ret = <PopupMenuEntry>[];
//    if (activity.status == ActivityStatus.Active) {
//      //active status
//      ret.addAll([
//        const PopupMenuItem(
//          child: ListTile(
//            leading: Icon(Icons.archive),
//            title: Text('archive'),
//          ),
//        ),
//        const PopupMenuItem(
//          child: ListTile(
//            leading: Icon(Icons.people),
//            title: Text('people'),
//          ),
//        ),
//      ]);
//    } else {
//      //archived
//      ret.add(const PopupMenuItem(
//        child: Icon(Icons.unarchive),
//      ));
//    }
//    return ret;
//  }

  void _backToListPage() {
    ActivityRepository().setCurrent(null);
    Navigator.pushReplacementNamed(context, AppRoute.activityList);
  }

  Widget _buildTabBar() {
    return SliverPersistentHeader(
      pinned: false,
      floating: false,
      delegate: _SliverAppBarDelegate(
        minHeight: 50.0,
        maxHeight: 50.0,
        child: Container(
            child: TabBar(
          tabs: _tabs,
          indicatorColor: Colors.black,
        )),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      leading:
          IconButton(icon: Icon(Icons.arrow_back), onPressed: _backToListPage),
      floating: false,
      pinned: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.share,
          ),
          onPressed: null,
        ),
        IconButton(
            icon: Icon(
              activity?.isFavorite == true ? Icons.star : Icons.star_border,
              color: Colors.red[500],
            ),
            onPressed: () async {
              activity.isFavorite = !activity.isFavorite;
              await ActivityRepository().changeFavorite(activity);
              setState(() {});
            }),
        IconButton(
            icon: Icon(
              Icons.settings
            ),
            onPressed: () async {
              Navigator.pushNamed(context, AppRoute.activityEdit,arguments: activity);
            }),
      ],
      title: Text(activity?.name ?? ""),
      backgroundColor: Colors.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) =>
                  <Widget>[_buildAppBar(), _buildTabBar()],
          body: new TabBarView(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  _buildActivityDes(activity),
                  ActivityStatisticsView(
                    activity: activity,
                  )
                ],
              ),
              ActivityNoteList(
                activity: activity,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
