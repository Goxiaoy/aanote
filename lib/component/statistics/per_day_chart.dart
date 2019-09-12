import 'package:aanote/model/statistics/activity_per_day_statistics.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:queries/collections.dart';
import 'package:intl/intl.dart';

class PerDayChart extends StatelessWidget {
  List<charts.Series> seriesList;
  final List<ActivityPerDayStatistics> activityPerDayStatistics;
  final bool animate;
  String initialDate;

  PerDayChart(this.activityPerDayStatistics, {this.animate}) {
    this.seriesList = _buildSeriesData(activityPerDayStatistics);
  }

  List<charts.Series> _buildSeriesData(List<ActivityPerDayStatistics> data) {
    var collection = Collection(data);
    var sorted=collection.orderByDescending((_) => _.date).toList();
    if(sorted.length<=0){
      return <charts.Series<ActivityPerDayStatistics, String>>[];
    }
    initialDate = formatTime(sorted.last.date.add(Duration(days: -7)));
    var grouped = collection.groupBy((p) => p.user.name);
    return grouped
        .select(
          (p) => charts.Series<ActivityPerDayStatistics, String>(
              id: p.key,
              domainFn: (a, b) => formatTime(a.date),
              measureFn: (a, b) => a.cost,
              data: p.toList()),
        )
        .toList();
  }

  String formatTime(DateTime time){
    return DateFormat('MM-dd').format(time);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.stacked,
      behaviors: [
        // Add the sliding viewport behavior to have the viewport center on the
        // domain that is currently selected.
        new charts.SlidingViewport(),
        // A pan and zoom behavior helps demonstrate the sliding viewport
        // behavior by allowing the data visible in the viewport to be adjusted
        // dynamically.
        new charts.PanAndZoomBehavior(),
      ],
      // Set an initial viewport to demonstrate the sliding viewport behavior on
      // initial chart load.
      domainAxis: new charts.OrdinalAxisSpec(
          viewport: new charts.OrdinalViewport(initialDate, 7)),
    );
  }
}
