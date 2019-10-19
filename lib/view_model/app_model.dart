import 'package:aanote/repositpory/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aanote/model/user.dart';

class AppModel extends ChangeNotifier{

  ///todo guide
  bool _isNeedGuide;

  ///todo guide
  bool get isNeedGuide => _isNeedGuide;

  ///has me added
  bool get hasMe => me!=null;

  User me;


  ThemeData theme=ThemeData.dark();

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

}