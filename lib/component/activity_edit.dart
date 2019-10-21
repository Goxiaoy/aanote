import 'dart:math';

import 'package:aanote/app_route.dart';
import 'package:aanote/model/activity.dart';
import 'package:aanote/model/activity_participation.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:aanote/view_model/activity_stat_model.dart';
import 'package:aanote/view_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:provider/provider.dart';
import 'package:logging/logging.dart';
import 'package:aanote/generated/i18n.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert';
import 'package:aanote/utils/color_extension.dart';

class ActivityEdit extends StatefulWidget {
  final Activity activity;

  const ActivityEdit({this.activity = null});

  @override
  State<StatefulWidget> createState() => _ActivityEditState(activity);
}

class _ActivityEditState extends State<ActivityEdit> {
  Activity activity;

  Logger _log = Logger("_ActivityEditState");

  _ActivityEditState(this.activity);

  static List<ColorSwatch> availableColors;

  bool _isAdd = false;

  AppModel _appModel;

  @override
  void initState() {
    super.initState();
    if (activity == null) {
      _isAdd = true;
      //get default setting
      ActivityRepository().getDefault().then((p) {
        activity = p;
        activity.color = _appModel
            .availableColors[Random().nextInt(_appModel.availableColors.length)]
            .value;
        setState(() {});
      });
    }
  }

  ///save add of
  void _addSave(ActivityStatModel model) async {
    assert(_isAdd);
    await ActivityRepository().add(activity);
    Navigator.pushReplacementNamed(context, AppRoute.activityDetail,
        arguments: Tuple2<String, bool>(activity.id, true));
    //should reload all active activity
    await model.loadActive();
  }

  /// save edit
  void _editSave() async {
    await ActivityRepository().update(activity);
  }

  Widget _buildEditForm() {
    if (!activity.participators.any((p) => p.userId == _appModel.me.id)) {
      activity.participators.insert(
          0,
          ActivityParticipation.fromUser(_appModel.me.id,
              activityId: activity.id));
      _log.info("Add me ${_appModel.me.name} to activity ${activity.name}");
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
                activity.name = val;
              },
            ),
            //TODO participator
            Container(
              padding: EdgeInsets.all(8),
              height: 300,
              child: BlockPicker(
                pickerColor: Color(activity.color),
                onColorChanged: (Color color) {
                  // Handle color changes
                  activity.color = color.value;
                  //form change
                  _editSave();
                  //theme change
                  setState(() {});
                },
                availableColors: _appModel.availableColors,
              ),
            )
          ],
        ),
        onChanged: () async {
          if (_isAdd) {
            return;
          }
          await _editSave();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = activity == null
        ? Theme.of(context)
        : Theme.of(context).copyWith(primaryColor: Color(activity.color));
    _appModel = Provider.of<AppModel>(context);
    return Theme(
      data: theme,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.primaryColor,
          title: Text(activity?.name ?? ""),
          centerTitle: true,
          actions: <Widget>[
            if (!_isAdd)
              Consumer<ActivityStatModel>(
                  builder: (context, model, child) => IconButton(
                      icon: Icon(Icons.check),
                      onPressed: () async => Navigator.pop(context)))
          ],
          automaticallyImplyLeading: false,
          leading: !_isAdd
              ? null
              : Consumer<ActivityStatModel>(
                  builder: (context, model, child) => IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () async {
                          //call refresh
                          await model.loadActive();
                          Navigator.pop(context);
                        },
                      )),
        ),
        body: activity != null ? _buildEditForm() : Container(),
        bottomNavigationBar: _isAdd ? _buildAddButton(theme) : null,
      ),
    );
  }

  Widget _buildAddButton(ThemeData themeData) {
    return new Padding(
        padding: new EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            bottom: 12),
        child: Consumer<ActivityStatModel>(
            builder: (context, model, child) => RaisedButton(
                  color: themeData.primaryColor,
                  child: Text(
                    S.of(context).createActivity,
                    style: themeData.textTheme.button,
                  ),
                  onPressed: () async => _addSave(model),
                )));
  }
}
