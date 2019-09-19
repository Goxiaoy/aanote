import 'package:flutter/material.dart';
import 'package:aanote/main_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        S.delegate,
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

