import 'package:sqflite/sqflite.dart';
import 'package:sqflite_auto_migration/sqflite_auto_migration.dart';

@MigrationVersion(1)
class Initial_20190924 extends MigrationBase {

  @override
  Future up(Batch batch) async {
    batch.execute('''
    CREATE TABLE activity (
      id           CHAR (36) PRIMARY KEY,
      status       STRING,
      name         STRING,
      isFavorite   BOOLEAN,
      favoriteTime DATETIME,
      creationTime    DATETIME,
      lastModificationTime DATETIME,
      endTime      DATETIME,
      color        STRING,
      [desc]       STRING
    );
    ''');
    batch.execute('''
    CREATE TABLE user (
      id           CHAR (36) PRIMARY KEY,
      name         STRING,
      lastModificationTime DATETIME,
      isMe   BOOLEAN
    );
    ''');
  }

  @override
  Future down(Batch batch) async {
    batch.execute('DROP TABLE IF EXISTS activity');
  }

}
