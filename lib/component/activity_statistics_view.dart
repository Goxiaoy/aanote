import 'package:aanote/component/value_change_animated_text.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/model/statistics/activity_per_day_statistics.dart';
import 'package:aanote/model/statistics/activity_total_statistics.dart';
import 'package:aanote/repositpory/activity_statistic_repository.dart';
import 'package:flutter/material.dart';
import 'package:aanote/component/statistics/per_day_chart.dart';
import 'package:aanote/component/statistics/category_pie_chart.dart';
import 'package:aanote/component/statistics/per_person_chart.dart';

class ActivityStatisticsView extends StatefulWidget{

  final Activity activity;

  ActivityStatisticsView({Key key, this.activity}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityStatisticsViewState(activityId:activity?.id);
  }
}

class _ActivityStatisticsViewState extends State<ActivityStatisticsView> {

  String activityId;

  ActivityTotalStatisticsType _totalStatisticsType =
      ActivityTotalStatisticsType.Team;

  _ActivityStatisticsViewState({@required this.activityId});


  Widget _buildTotalStatistics() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<ActivityTotalStatistics>(
            future: ActivityStatisticsRepository()
                .getTotal(activityId: activityId, type: _totalStatisticsType),
            builder: (c, snapshot) {
              return new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Total cost:"),
//                    Text(snapshot.data?.totalCost.toString()),
                    ValueChangeAnimatedText(initialValue: snapshot.data?.totalCost??0,),
                    Container(
                      height: 20,
                      child: VerticalDivider(
                        width: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text("AverageDay cost:" ),
//                    Text(snapshot.data?.averageDayCost.toString()),
                    ValueChangeAnimatedText(initialValue: snapshot.data?.averageDayCost??0,),
                  ]);
            }));
  }

  Widget _buildPerDay() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: 300,
        child: FutureBuilder<List<ActivityPerDayStatistics>>(
          future: ActivityStatisticsRepository()
              .getPerDayStatistics(activityId: activityId),
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

  Widget _buildPerPersonChart() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: 300,
        child: PerPersonChart.withSampleData());
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Card(
          child: _buildTotalStatistics(),
        ),
        Card(child: _buildPerDay()),
        Card(child: _buildCategoryPie()),
        Card(
          child: _buildPerPersonChart(),
        )
      ],
    );
  }
}