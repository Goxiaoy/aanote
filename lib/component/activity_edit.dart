import 'package:aanote/app_route.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/model/activity_participation.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:aanote/view_model/activity_stat_model.dart';
import 'package:aanote/view_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:aanote/generated/i18n.dart';
import 'package:tuple/tuple.dart';

class ActivityEdit extends StatefulWidget {
  final Activity activity;

  const ActivityEdit({this.activity = null});

  @override
  State<StatefulWidget> createState() => _ActivityEditState(activity);
}

class _ActivityEditState extends State<ActivityEdit> {
  Activity activity;

  Logger _log=Logger("_ActivityEditState");

  _ActivityEditState(this.activity);

  bool _isAdd=false;

  @override
  void initState() {
    super.initState();
    if (activity == null) {
      _isAdd=true;
      //get default setting
      ActivityRepository().getDefault().then((p) {
        setState(() {
          activity = p;
        });
      });
    }
  }

  ///save add of
  void _save(ActivityStatModel model) async{
    if(_isAdd){
      await ActivityRepository().add(activity);
      Navigator.pushReplacementNamed(context, AppRoute.activityDetail,arguments: Tuple2<String,bool>(activity.id,true));
    }else{
      //
    }
    //should reload all active activity
    await model.loadActive();
  }

  Widget _buildEditForm(BuildContext context){
      return Consumer<AppModel>(builder: (context,appModel,child){
        if(!activity.participators.any((p)=>p.userId==appModel.me.id)){
          activity.participators.insert(0, ActivityParticipation.fromUser(appModel.me.id, activityId: activity.id));
          _log.info("Add me ${appModel.me.name} to activity ${activity.name}");
        }
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                //name
                new TextFormField(
                  initialValue: activity.name,
                  decoration: new InputDecoration(
                    labelText: S.of(context).activityName,
                  ),
                  onSaved: (val) {
                    activity.name=val;
                  },
                ),
                //TODO color
                //TODO participator
              ],
            ),
          ),
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(activity?.name??""),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ActivityStatModel>(builder: (context,model,child)=>IconButton(icon: Icon(Icons.check), onPressed: ()async=>_save(model)))
        ],
      ),
      body: activity!=null?_buildEditForm(context):Container(),
    );
  }
}
