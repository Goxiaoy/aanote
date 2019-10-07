import 'package:aanote/repositpory/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier{

  ///todo guide
  bool _isNeedGuide;

  ///todo guide
  bool get isNeedGuide => _isNeedGuide;


  ///has me added
  bool _hasMe=false;

  ///has me added
  bool get hasMe => _hasMe;


  ThemeData theme=ThemeData.dark();


  ///load has me form db
  Future<bool> loadHasMe() async {
    if(hasMe){
      //do not have to load again
      return true;
    }
    var me=await UserRepository().findMe();
    var newHasMe=me!=null;
    if(hasMe!=newHasMe){
      _hasMe=newHasMe;
      notifyListeners();
    }
    return hasMe;
  }

}