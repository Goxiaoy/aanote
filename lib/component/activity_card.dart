import 'package:aanote/component/activity_statistics_per_day_chart.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/model/statistics/activity_per_day_statistics.dart';
import 'package:aanote/model/statistics/activity_total_statistics.dart';
import 'package:aanote/repositpory/activity_statistic_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  initState() {
    super.initState();
  }

  Widget _buildActivityTotal() {
    var statement = <Widget>[
      new Container(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: new Text(
          activity.name,
          style: new TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ];
    if (activity.desc != null) {
      statement.add(new Text(
        activity.desc,
      ));
    }
    statement.add(new Text(
      "StartTime: " + new DateFormat('yyyy-MM-dd').format(activity.startTime),
    ));
    return new Container(
        padding: const EdgeInsets.all(40.0),
        child: new Row(
          children: <Widget>[
            new Expanded(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: statement,
            )),
            new Icon(
              activity.isFavorite ? Icons.star : Icons.star_border,
              color: Colors.red[500],
            ),
          ],
        ));
  }

  Widget _buildTotalStatistics() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<ActivityTotalStatistics>(
            future: ActivityStatisticsRepository()
                .getTotal(activityId: activity.id, type: _totalStatisticsType),
            builder: (c, snapshot) {
              return new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Total cost:" + snapshot.data?.totalCost?.toString() ??
                        ""),
                    Container(
                      height: 20,
                      child: VerticalDivider(
                        width: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text("Total cost:" + snapshot.data?.totalCost?.toString() ??
                        "")
                  ]);
            }));
  }

  Widget _buildOtherStatistics() {
    var perDay = Container(
        padding: const EdgeInsets.all(10.0),
        height: 300,
        child: FutureBuilder<List<ActivityPerDayStatistics>>(
          future: ActivityStatisticsRepository()
              .getPerDayStatistics(activityId: activity.id),
          builder: (c, snapshot) {
            return ActivityStatisticsPerDayChart(snapshot.data,animate: true,);
          },
        ));
    

    return perDay;
  }

  @override
  Widget build(BuildContext context) {
    return
        Container(
            color: Colors.grey,
            width: double.infinity,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Card(
                    child: _buildActivityTotal(),
                  ),
                ),
                Center(
                  child: Card(
                    child: _buildTotalStatistics(),
                  ),
                ),
                Center(
                  //other statistics card
                  child: Card(
                    child: _buildOtherStatistics(),
                  ),
                ),
              ],
            ));
  }
}
