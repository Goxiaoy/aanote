import 'package:aanote/model/user.dart';
import 'package:aanote/repositpory/sqlite_repository_base.dart';
import 'package:aanote/utils/convert.dart';
import 'package:flutter/cupertino.dart';

final String table_user="user";
class UserRepository extends SqliteRepositoryBase{

  ///add user
  Future<User> add(User user) async{
    return await db.then((db) async{
      await db.insert(table_user, user.toJson());
      return user;
    });
  }

  Future<User> get(String id) async{
    return await db.then((db) async{
      var maps=await db.query(table_user,where: 'id = ?',whereArgs: [id]);
      if (maps.length > 0) {
        return User.fromJson(maps.first);
      }
      return null;
    });
  }

  Future<List<User>> all() async{
    return await db.then((db) async{
      var maps=await db.query(table_user);
      return maps.map((p)=>User.fromJson(p)).toList();
    });
  }

  Future<User> findMe() async{
    return await db.then((db) async{
      var raw=await db.query(table_user,where: 'isMe=?',whereArgs: [boolToInt(true)]);
      if(raw.length>0){
        return User.fromJson(raw.first);
      }else{
        return null;
      }
    });
  }

  ///updater user's name
  Future<User> update({@required String id,String name}) async {
    var user=await get(id);
    if(user==null){
      throw ArgumentError.value(name);
    }
    user.name=name;
    await db.then((db) async{
      await db.update(table_user, user.toJson(),where: 'id=?',whereArgs: [id]);
    });
    return user;
  }

}