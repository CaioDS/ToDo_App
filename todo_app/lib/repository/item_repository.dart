import 'dart:io';
import 'dart:convert';

import 'package:todo_app/models/Item.dart';
import 'package:path_provider/path_provider.dart';

class ItemRepository {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.json');
  }

  Future<List<Item>> readData() async {
    try{
      final file = await _localFile;
      String dataJson = await file.readAsString();
      List<Item> data = (json.decode(dataJson) as List).map((i) => Item.FromJson(i)).toList();
      return data;
    } catch (error) {
      return List<Item>();
    }
  }

  Future<bool> saveData(List<Item> list) async {
    try {
      final file = await _localFile;
      final String data = json.encode(list);
      file.writeAsString(data);
      return true;

    } catch(error) {
      return false;
    }
  }

}