@Skip("sqflite cannot run on the machine.")

import 'package:aanote/model/activity.dart';
import 'package:aanote/model/user.dart';
import 'package:aanote/persistent/db_factory.dart';
import 'package:aanote/repositpory/activity_repository.dart';
import 'package:aanote/repositpory/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

void main() async {
  group("activity_repository_test", () {
    Database db;
    setUp(() async {
      db = await DbFactory().open();
    });
    tearDownAll(() async {
      await DbFactory().delete();
    });

    test("migration", () async {
      var tables =
          await db.rawQuery("select * from sqlite_master where type=\"table\"");
      print(tables);
    });

    var a1Id = Uuid().v4();
    test("activity_repository_add", () async {
      var activity = Activity(id: a1Id, name: "A1", startTime: DateTime.now());
      await ActivityRepository().add(activity);
      print(await db.rawQuery("select * from activity"));
      expect(
          Sqflite.firstIntValue(
              await db.rawQuery("select count(*) from activity")),
          1);
    });

    test("activity_repository_get", () async {
      var a1 = await ActivityRepository().get(a1Id);
      expect(a1 != null && a1.name == 'A1', true);
    });

    test("activity_repository_getActive", () async {
      var archived = Activity(name: "A2", startTime: DateTime.now())..archive();
      await ActivityRepository().add(archived);
      print("add sucess");
      var activeActivities = await ActivityRepository().getActive();
      expect(activeActivities.length, 1);
      expect(activeActivities.first.name, "A1");
    });
  });

  group("user_repository_test", () {
    Database db;
    setUp(() async {
      db = await DbFactory().open();
    });
    tearDownAll(() async {
      await DbFactory().delete();
    });
    var userId = Uuid().v4();
    test("add", () async {
      for (var u in [
        User(id: userId, name: "U1", isMe: true),
        User(name: "U2"),
      ]) {
        await UserRepository().add(u);
      }
      expect(
          Sqflite.firstIntValue(await db.rawQuery("select count(*) from user")),
          2);
    });

    test("all", () async {
      var all=await UserRepository().all();
      print(all);
      expect(all.length, 2);
    });

    test("findMe", () async {
      var me=await UserRepository().findMe();
      expect(me?.id, userId);
    });

    test("get", () async {
      var user=await UserRepository().get(userId);
      expect(user?.name, "U1");
    });
  });
}
