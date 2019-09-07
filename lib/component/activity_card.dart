import 'package:aanote/model/activity.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatefulWidget {

  final Activity activity;
  final double parallaxPercent;

  const ActivityCard({ @required this.activity, this.parallaxPercent = 0.0}) ;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ActivityCardState();
  }
}

class _ActivityCardState extends State<ActivityCard>
    with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(color: Colors.black,width: double.infinity,),
      ],
    );
  }
}

