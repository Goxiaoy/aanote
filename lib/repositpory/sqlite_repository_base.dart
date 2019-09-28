import 'package:aanote/persistent/db_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

abstract class SqliteRepositoryBase{
  @protected
  Future<Database> db=DbFactory().open();
}