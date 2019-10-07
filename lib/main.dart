import 'package:aanote/activity_list_page.dart';
import 'package:aanote/component/activity_card.dart';
import 'package:aanote/initial_page.dart';
import 'package:aanote/view_model/activity_stat_model.dart';
import 'package:aanote/view_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:aanote/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/i18n.dart';
import 'package:aanote/utils/environment.dart';
import 'package:sqflite/sqflite.dart';
import 'app_route.dart';
import 'package:logging/logging.dart';


void main() async{
  if(!inProduction){
    Sqflite.devSetDebugModeOn(true);
  }
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((LogRecord rec) {
    if (!inProduction) {
      print('[${rec.level.name}][${rec.time}][${rec.loggerName}]: ${rec.message}');
    }
  });

  //init
  await SharedPreferences.getInstance();
  runApp(new MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_MyAppState();

}


class _MyAppState extends State<MyApp>{

  final AppModel _appModel=AppModel();
  final ActivityStatModel _activityStatModel=ActivityStatModel();


  @override
  void initState() {
    super.initState();
    _appModel.loadHasMe();
    _activityStatModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppModel>.value(value: _appModel),
        ChangeNotifierProvider<ActivityStatModel>.value(value: _activityStatModel),
      ],
      child: Consumer2<AppModel,ActivityStatModel>(
        builder: (context, appModel,asModel, child) {
          return MaterialApp(
            localizationsDelegates: [
              S.delegate,
              RefreshLocalizations.delegate,
              // ... app-specific localization delegate[s] here
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: appModel.theme,
            home: !appModel.hasMe ? InitialPage() : (asModel.currentActivityId!=null?ActivityCard(activityId: asModel.currentActivityId,):ActivityListPage()),
            //initialRoute: AppRoute.initial,
            onGenerateRoute: AppRoute.generateRoute,//MainPage
          );
        },
      ),
    );
  }
}


