import 'dart:math';

import 'package:aanote/component/statistics/category_pie_chart.dart';
import 'package:aanote/component/statistics/per_day_chart.dart';
import 'package:aanote/component/statistics/per_person_chart.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/model/category.dart';
import 'package:aanote/model/statistics/activity_per_day_statistics.dart';
import 'package:aanote/model/statistics/activity_total_statistics.dart';
import 'package:aanote/repositpory/activity_statistic_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ActivityCard extends StatefulWidget {
  final Activity activity;
  final double parallaxPercent;

  const ActivityCard({@required this.activity, this.parallaxPercent = 0.0});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityCardState();
  }
}

class _ActivityCardState extends State<ActivityCard>
    with TickerProviderStateMixin {
  Activity get activity => widget.activity;

  ActivityTotalStatisticsType _totalStatisticsType =
      ActivityTotalStatisticsType.Team;

  ActivityTotalStatistics _totalStatistics;

  TabController tabController;

  @override
  initState() {
    super.initState();
    this.tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildTotalStatistics() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<ActivityTotalStatistics>(
            future: ActivityStatisticsRepository()
                .getTotal(activityId: activity.id, type: _totalStatisticsType),
            builder: (c, snapshot) {
              return new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Total cost:" +
                        (snapshot.data?.totalCost?.toString() ?? "")),
                    Container(
                      height: 20,
                      child: VerticalDivider(
                        width: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text("Total cost:" +
                        (snapshot.data?.totalCost?.toString() ?? ""))
                  ]);
            }));
  }

  Widget _buildPerDay() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: 300,
        child: FutureBuilder<List<ActivityPerDayStatistics>>(
          future: ActivityStatisticsRepository()
              .getPerDayStatistics(activityId: activity.id),
          builder: (c, snapshot) {
            return PerDayChart(
              snapshot.data,
              animate: true,
            );
          },
        ));
  }

  Widget _buildCategoryPie() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: 300,
        child: CategoryPieChart.withSampleData());
  }

  Widget _buildActivityDes() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 5, top: 10),
                child: new Text(
                  activity.desc ?? "",
                ),
              ),
              Row(
                children: <Widget>[
                  new Text(
                    "StartTime: " +
                        new DateFormat('yyyy-MM-dd').format(activity.startTime),
                  ),
                  new Text(
                    activity.endTime == null
                        ? ""
                        : ("EndTime: " +
                            new DateFormat('yyyy-MM-dd')
                                .format(activity.endTime)),
                  )
                ],
              )
            ]));
  }

  Widget _buildPerPersonChart() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: 300,
        child: PerPersonChart.withSampleData());
  }

  List<PopupMenuEntry> _buildPopupMenu() {
    var ret = <PopupMenuEntry>[];
    if (activity.status == ActivityStatus.Active) {
      //active status
      ret.addAll([
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.archive),
            title: Text('archive'),
          ),
        ),
        const PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.people),
            title: Text('people'),
          ),
        ),
      ]);
    } else {
      //archived
      ret.add(const PopupMenuItem(
        child: Icon(Icons.unarchive),
      ));
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white10,
        width: double.infinity,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                ),
                onPressed: null,
              ),
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
                      activity.isFavorite ? Icons.star : Icons.star_border,
                      color: Colors.red[500],
                    ),
                    onPressed: null),
                PopupMenuButton(
                  itemBuilder: (BuildContext context) => _buildPopupMenu(),
                )
              ],
              title: Text(activity.name),
              backgroundColor: Colors.grey,
              // floating: floating,
              // snap: snap,
              // pinned: pinned,
            ),
            SliverPersistentHeader(
              pinned: false,
              floating: false,
              delegate: _SliverAppBarDelegate(
                minHeight: 50.0,
                maxHeight: 50.0,
                child: TabBar(tabs: <Widget>[
                  ListTile(leading: Icon(Icons.pie_chart),title: Text("Statistics"),),
                  ListTile(leading: Icon(Icons.list),title: Text("Detail"),)
                ],controller: this.tabController,indicatorColor: Colors.black,),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                _buildActivityDes(),
                Card(
                  child: _buildTotalStatistics(),
                ),
                Card(child: _buildPerDay()),
                Card(child: _buildCategoryPie()),
                Card(
                  child: _buildPerPersonChart(),
                )
              ]),
            )

//            SliverToBoxAdapter(child:Center(child: _buildActivityTotal())),
//            SliverToBoxAdapter(child: Center(
//              child: Card(
//                child: _buildTotalStatistics(),
//              ),
//            ),),
//            Center(
//              //other statistics card
//              child: Card(
//                child: _buildOtherStatistics(),
//              ),
//            ),
          ],
        ));
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
