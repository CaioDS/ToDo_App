import 'dart:io';
import 'dart:convert';

import 'package:todo_app/models/Lista.dart';
import 'package:path_provider/path_provider.dart';

class ListRepository {

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/list.json');
  }

  Future<List<Lista>> readData() async {
    try{
      final file = await _localFile;
      String dataJson = await file.readAsString();
      List<Lista> data = (json.decode(dataJson) as List).map((i) => Lista.FromJson(i)).toList();
      return data;
    } catch (error) {
      return List<Lista>();
    }
  }

  Future<bool> saveData(List<Lista> list) async {
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