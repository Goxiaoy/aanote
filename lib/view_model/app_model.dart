import 'package:aanote/repositpory/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aanote/entity/user.dart';
import 'dart:convert';
import 'package:aanote/utils/color_extension.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppModel extends ChangeNotifier{

  ///todo guide
  bool _isNeedGuide;

  ///todo guide
  bool get isNeedGuide => _isNeedGuide;

  ///has me added
  bool get hasMe => me!=null;

  User me;


  ThemeData theme=ThemeData.dark();


  List<MaterialColor> availableColors;

  ///load has me form db
  Future<bool> loadHasMe() async {
    if(hasMe){
      //do not have to load again
      return true;
    }
    User oldMe=me;
    me=await UserRepository().findMe();
    if(me?.lastModificationTime!=oldMe?.lastModificationTime){
      notifyListeners();
    }
    return hasMe;
  }

  ThemeData getTheme({bool platformDark=false}){
    if(platformDark){
      return ThemeData.dark();
    }else{
      return ThemeData.light();
    }
  }

  ///available colors
  Future<List<ColorSwatch>> getAvailableColors() async {
    if (availableColors == null) {
      var colors =
      await rootBundle.loadString("assets/colors.json");
      List<dynamic> colorObject = json.decode(colors) as List<dynamic>;
      availableColors = colorObject.map((p) {
        var hex = p['hex'] as String;
        Color primaryColor = HexColor.fromHex(hex);
        var colorsArray = p['colors'] as List<dynamic>;
        var index = 0;
        var secondaryColors = Map.fromEntries(colorsArray.map((p) {
          var key = index == 0 ? 50 : index * 100;
          index++;
          return MapEntry(key, HexColor.fromHex(p['hex'] as String));
        }));
        return MaterialColor(primaryColor.value, secondaryColors);
      }).toList();
    }
    return availableColors;
  }
}