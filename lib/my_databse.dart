import 'dart:async';
import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase{
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'new_database.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "new_database.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/database', 'new_database.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String,Object?>>> grtDetail() async {
    Database db=await initDatabase();
    List<Map<String,Object?>> list= await db.rawQuery('select * from user_details');
    return list;
  }

  Future<int> insertUser(Map<String,Object?> map) async {
    Database db=await initDatabase();
    var res=await db.insert('user_details', map);
    return res;
  }

  Future<int> editUser(Map<String,Object?> map,id) async {
    Database db=await initDatabase();
    var res=await db.update('user_details', map,where: 'userId=?',whereArgs: [id]);
    return res;
  }

  Future<void> deleteUser(id) async {
    Database db=await initDatabase();
    await db.delete('user_details',where: 'userId=?',whereArgs: [id]);
  }

}