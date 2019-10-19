import 'package:sqflite/sqflite.dart';
import 'package:sqflite_auto_migration/sqflite_auto_migration.dart';

import 'package:aanote/persistent/migration/initial_20190924.dart';

final Map<int, MigrationBase> migrations={1: Initial_20190924()};

OpenDatabaseOptions get options => OpenDatabaseOptions(
    //latest version define in the migrations
    version: 1,
    onCreate: (db, version) async {
      var batch = db.batch();
      for (var m in migrations.entries) {
        await m.value.up(batch);
      }
      await batch.commit();
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      for (var m in migrations.entries) {
        if (m.key > oldVersion && m.key <= newVersion) await m.value.up(batch);
      }
    },
    onDowngrade: (db, oldVersion, newVersion) async {
      var batch = db.batch();
      for (var m in migrations.entries) {
        if (m.key <= oldVersion && m.key > newVersion)
          await m.value.down(batch);
      }
      await batch.commit();
    });



