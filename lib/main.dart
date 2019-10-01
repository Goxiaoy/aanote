import 'package:aanote/initial_page.dart';
import 'package:aanote/view_model/app_model.dart';
import 'package:flutter/material.dart';
import 'package:aanote/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'generated/i18n.dart';
import 'package:aanote/utils/environment.dart';
import 'package:sqflite/sqflite.dart';
import 'app_route.dart';
import 'package:logging/logging.dart';


void main() {
  if(!inProduction){
    Sqflite.devSetDebugModeOn(true);
  }
  Logger.root.level = Level.FINE;
  Logger.root.onRecord.listen((LogRecord rec) {
    if (!inProduction) {
      print('[${rec.level.name}][${rec.time}][${rec.loggerName}]: ${rec.message}');
    }
  });
  runApp(new MyApp());
}




class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: providers,
      child: Consumer<AppModel>(
        builder: (context,appModel,child){
          appModel.loadHasMe();
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
            home: appModel.hasMe?MainPage():InitialPage(),
            initialRoute: AppRoute.initial,//MainPage
          );
        },
      ),
    ) ;
  }

}


final List<SingleChildCloneableWidget> providers = [
  ChangeNotifierProvider<AppModel>.value(value: AppModel())
];


