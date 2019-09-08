import 'package:aanote/model/statistics/activity_per_day_statistics.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:queries/collections.dart';
import 'package:intl/intl.dart';

class ActivityStatisticsPerDayChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final List<ActivityPerDayStatistics> activityPerDayStatistics;
  final bool animate;

  ActivityStatisticsPerDayChart(this.activityPerDayStatistics, {this.animate})
      : seriesList = _buildSeriesData(activityPerDayStatistics);

  static List<charts.Series> _buildSeriesData(
      List<ActivityPerDayStatistics> data) {
    var collection = Collection(data);
    var grouped = collection.groupBy((p) => p.user.name);
    return grouped
        .select(
            (p) => charts.Series<ActivityPerDayStatistics, String>(
                id: p.key,
                domainFn: (a, b) => DateFormat('yyyy-MM-dd').format(a.date),
                measureFn: (a, b) => a.cost,
                data:p.orderBy((_)=>_.date).toList()),
               )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,

    );
  }

}

