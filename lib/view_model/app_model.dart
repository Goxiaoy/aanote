import 'package:aanote/repositpory/user_repository.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier{

  ///todo guide
  bool isNeedGuide;

  ///has me added
  bool hasMe=false;

  bool hasActivity;

  ThemeData theme=ThemeData.dark();


  Future<bool> loadHasMe() async {
    if(hasMe){
      //do not have to load again
      return true;
    }
    var me=await UserRepository().findMe();
    var newHasMe=me!=null;
    if(hasMe!=newHasMe){
      hasMe=newHasMe;
      notifyListeners();
    }
    return hasMe;
  }

}