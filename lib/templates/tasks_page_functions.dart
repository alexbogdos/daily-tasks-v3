import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Save List function template
void saveLists(
    {required List<String> tasksList,
    required List<String> archivedList,
    required List<String> datesList,
    required String key}) async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_$key', tasksList);
  await prefs.setStringList('archivedList_$key', archivedList);
  await prefs.setStringList('datesList_$key', datesList);
}

Future<List<List<String>>> retrieveLists(
    {required List<String> tasksList,
    required List<String> archivedList,
    required List<String> datesList,
    required String key}) async {
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_$key')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_$key');
    if (_tasksList != null) {
      tasksList = _tasksList;
    }
  } else {
    if (kDebugMode) {
      print("tasksList_$key not in memory");
    }
  }

  if (prefs.containsKey('archivedList_$key')) {
    final List<String>? _archivedList =
        prefs.getStringList('archivedList_$key');
    if (_archivedList != null) {
      archivedList.addAll(_archivedList);
    }
  } else {
    if (kDebugMode) {
      print("archivedList_$key not in memory");
    }
  }

  if (prefs.containsKey('datesList_$key')) {
    final List<String>? _datesList = prefs.getStringList('datesList_$key');
    if (_datesList != null) {
      datesList = _datesList;
    }
  } else {
    if (kDebugMode) {
      print("datesList_$key not in memory");
    }
  }

  return [tasksList, archivedList, datesList];
}

Future<List<String>> getFilePath(
    {required String key, required String rootPath}) async {
  String name = '${key[0].toUpperCase()}${key.substring(1)}';

  if (!Directory("$rootPath/$name").existsSync()) {
    Directory("$rootPath/$name").createSync(recursive: true);
  }

  String filePathTasksList = '$rootPath/$name/tasksList.txt';
  String filePathArchivedList = '$rootPath/$name/archivedList.txt';
  String filePathDatesList = '$rootPath/$name/datesList.txt';

  return [filePathTasksList, filePathArchivedList, filePathDatesList];
}

Future<void> saveFile(
    {required List<String> tasksList,
    required List<String> archivedList,
    required List<String> datesList,
    required String key,
    required String rootPath}) async {
  List<String> filePaths = await getFilePath(key: key, rootPath: rootPath);

  File fileTasksList = File(filePaths[0]);
  String string = "";
  if (kDebugMode) {
    print("tasklist: $tasksList  length: ${tasksList.length}");
  }
  for (int index = 0; index < tasksList.length; index++) {
    if (index < tasksList.length - 1) {
      string += "${tasksList[index]}<||>";
    } else {
      string += tasksList[index];
    }
  }
  fileTasksList.writeAsString(string);

  File fileArchivedList = File(filePaths[1]);
  string = "";
  for (int index = 0; index < archivedList.length; index++) {
    if (index < archivedList.length - 1) {
      string += "${archivedList[index]}<||>";
    } else {
      string += archivedList[index];
    }
  }
  fileArchivedList.writeAsString(string);

  File fileDatesList = File(filePaths[2]);
  string = "";
  for (int index = 0; index < datesList.length; index++) {
    if (index < datesList.length - 1) {
      string += "${datesList[index]}<||>";
    } else {
      string += datesList[index];
    }
  }
  fileDatesList.writeAsString(string);

  if (kDebugMode) {
    print("Lists Saved");
  }
}

Future<List<List<String>>> readFile(
    {required List<String> tasksList,
    required List<String> archivedList,
    required List<String> datesList,
    required String key,
    required String rootPath}) async {
  List<String> filePaths = await getFilePath(key: key, rootPath: rootPath);

  if (await File(filePaths[0]).exists()) {
    File fileTasksList = File(filePaths[0]);
    String fileContentTasksList = await fileTasksList.readAsString();
    if (fileContentTasksList != "") {
      tasksList = fileContentTasksList.split('<||>');
    } else {
      tasksList = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'tasksList' don't exists");
    }
  }

  if (await File(filePaths[1]).exists()) {
    File fileArchivedList = File(filePaths[1]);
    String fileContentArchivedList = await fileArchivedList.readAsString();
    if (fileContentArchivedList != "") {
      archivedList = fileContentArchivedList.split('<||>');
    } else {
      archivedList = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'archivedList' don't exists");
    }
  }

  if (await File(filePaths[2]).exists()) {
    File fileDatesList = File(filePaths[2]);
    String fileContentDatesList = await fileDatesList.readAsString();
    if (fileContentDatesList != "") {
      datesList = fileContentDatesList.split('<||>');
    } else {
      datesList = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'datesList' don't exists");
    }
  }

  saveLists(
      tasksList: tasksList,
      archivedList: archivedList,
      datesList: datesList,
      key: key);

  return [tasksList, archivedList, datesList];
}
