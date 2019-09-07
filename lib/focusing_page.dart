import 'package:aanote/component/activity_card.dart';
import 'package:aanote/component/bottom_bar.dart';
import 'package:aanote/component/card_flipper.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:flutter/material.dart';
import 'package:aanote/model/activity.dart';
import 'package:logging/logging.dart';

class FocusingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _FocusingPageState();
  }
}

class _FocusingPageState extends State<FocusingPage> {
  final _log = Logger("_FocusingPageState");

  double scrollPercent = 0.0;

  ///active activity will show in focusing page
  List<Activity> activeActivities;

  @override
  void initState() {
    super.initState();
    activeActivities = List();
  }

  /// build activities cards
  List<Widget> _buildActivitiesCards() {
    return activeActivities.map((p) => ActivityCard(activity: p)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: _buildFuture, future: ActivityRepository().getActive().then((p)=>activeActivities=p));
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot<List<Activity>> snapshot) {
    if (snapshot.data!=null&&snapshot.data.length>0) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 20.0,
            ),
            Expanded(
              child: CardFlipper(
                  cards: _buildActivitiesCards(),
                  onScroll: (double sp) {
                    setState(() {
                      this.scrollPercent = sp;
                    });
                  }),
            ),
            BottomBar(
                cardCount: activeActivities.length, scrollPercent: scrollPercent)
          ]);
    } else {
      //todo tips to let user add activity
      return  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Container(
          width: double.infinity,
          height: 20.0,
        )
      ]);
    }
  }
}
