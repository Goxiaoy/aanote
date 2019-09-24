import 'package:flutter/material.dart';
import 'package:aanote/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'generated/i18n.dart';
import 'package:aanote/utils/environment.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  if(!inProduction){
    Sqflite.devSetDebugModeOn(true);
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        S.delegate,
        RefreshLocalizations.delegate,
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),//MainPage
    );
  }
}

