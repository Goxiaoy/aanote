import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:logging/logging.dart';
import 'package:aanote/generated/migration_function.dart';
import 'package:sqflite/sqlite_api.dart';
class DbFactory{

  Logger _log=Logger("DbFactory");

  final String dbName;

  DbFactory._(this.dbName);

  static DbFactory _instance=DbFactory._("store.db");

  factory DbFactory()=>_instance;

  Completer<Database> _dbCompleter;

  Future<Database> open() async{
    if(_dbCompleter!=null){
      return _dbCompleter.future;
    }
    _dbCompleter=Completer();
    _openInternal().then((db){
      _dbCompleter.complete(db);
    });
    return _dbCompleter.future;
  }

  ///delete db
  Future delete() async{
    //close db?
    if(_dbCompleter!=null){
      //db opened
      var db=await _dbCompleter.future;
      db.close();
    }
    var path=await _getDbPath();
    await deleteDatabase(path);
  }

  Future<String> _getDbPath() async{
     var dbPath=await getDatabasesPath();
     return join(dbPath, dbName);
  }

  Future<Database> _openInternal() async{
      var path=await _getDbPath();
//    // delete existing if any
//    await deleteDatabase(path);

    var exists=await databaseExists(path);
    if (!exists) {
      // Should happen only the first time you launch your application
      _log.info("Creating new copy from asset");
      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {
      }
      try{
        // Copy from asset
        ByteData data = await rootBundle.load(join("assets", "initial.db"));
        List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        // Write and flush the bytes written
        await File(path).writeAsBytes(bytes, flush: true);
      }catch (_){
        //todo asset not found error
        //todo space error
      }


    } else {
      _log.info("Opening existing database");
    }
    var migrationOptions=options;
// open the database
    var db = await databaseFactory.openDatabase(path,options:migrationOptions);
    print("Open db in $path success");
    return db;
  }

}