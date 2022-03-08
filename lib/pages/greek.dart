// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage pageGreek = TasksPage(
  title: "Greek",
  backgroundColors: const [Color(0xffFFD6A5), Color(0xffCAFFBF)],
  tasksList: tasksList_greek,
  archivedList: archivedList_greek,
  datesList: datesList_greek,
  saveLists: saveLists_greek,
);

List<String> tasksList_greek = [];

List<String> archivedList_greek = [];
List<String> datesList_greek = [];

void saveLists_greek() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_greek', tasksList_greek);
  await prefs.setStringList('archivedList_greek', archivedList_greek);
  await prefs.setStringList('datesList_greek', datesList_greek);
}

Future<void> retrieveLists_greek() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_greek')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_greek');
    if (_tasksList != null) {
      tasksList_greek = _tasksList;
    }
  } else {
    if (kDebugMode) {
      print("tasksList_greek not in memory");
    }
  }

  if (prefs.containsKey('archivedList_greek')) {
    final List<String>? _archivedList =
        prefs.getStringList('archivedList_greek');
    if (_archivedList != null) {
      archivedList_greek.addAll(_archivedList);
    }
  } else {
    if (kDebugMode) {
      print("archivedList_greek not in memory");
    }
  }

  if (prefs.containsKey('datesList_greek')) {
    final List<String>? _datesList = prefs.getStringList('datesList_greek');
    if (_datesList != null) {
      datesList_greek = _datesList;
    }
  } else {
    if (kDebugMode) {
      print("datesList_greek not in memory");
    }
  }
}

Future<List<String>> getFilePath(String rootPath) async {
  String name = "Greek";

  if (!Directory("$rootPath/$name").existsSync()) {
    Directory("$rootPath/$name").createSync(recursive: true);
  }

  String filePath_tasksList = '$rootPath/$name/tasksList.txt';
  String filePath_archivedList = '$rootPath/$name/archivedList.txt';
  String filePath_datesList = '$rootPath/$name/datesList.txt';

  return [filePath_tasksList, filePath_archivedList, filePath_datesList];
}

Future<void> saveFile_greek(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  File file_tasksList = File(filePaths[0]);
  String string = "";
  if (kDebugMode) {
    print("tasklist: $tasksList_greek  length: ${tasksList_greek.length}");
  }
  for (int index = 0; index < tasksList_greek.length; index++) {
    if (index < tasksList_greek.length - 1) {
      string += "${tasksList_greek[index]}<||>";
    } else {
      string += tasksList_greek[index];
    }
  }
  await file_tasksList.writeAsString(string);

  File file_archivedList = File(filePaths[1]);
  string = "";
  for (int index = 0; index < archivedList_greek.length; index++) {
    if (index < archivedList_greek.length - 1) {
      string += "${archivedList_greek[index]}<||>";
    } else {
      string += archivedList_greek[index];
    }
  }
  await file_archivedList.writeAsString(string);

  File file_datesList = File(filePaths[2]);
  string = "";
  for (int index = 0; index < datesList_greek.length; index++) {
    if (index < datesList_greek.length - 1) {
      string += "${datesList_greek[index]}<||>";
    } else {
      string += datesList_greek[index];
    }
  }
  await file_datesList.writeAsString(string);

  if (kDebugMode) {
    print("Lists Saved");
  }
}

Future<void> readFile_greek(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  if (await File(filePaths[0]).exists()) {
    File file_tasksList = File(filePaths[0]);
    String fileContent_tasksList = await file_tasksList.readAsString();
    if (fileContent_tasksList != "") {
      tasksList_greek = fileContent_tasksList.split('<||>');
    } else {
      tasksList_greek = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'tasksList' don't exists");
    }
  }

  if (await File(filePaths[1]).exists()) {
    File file_archivedList = File(filePaths[1]);
    String fileContent_archivedList = await file_archivedList.readAsString();
    if (fileContent_archivedList != "") {
      archivedList_greek = fileContent_archivedList.split('<||>');
    } else {
      archivedList_greek = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'archivedList' don't exists");
    }
  }

  if (await File(filePaths[2]).exists()) {
    File file_datesList = File(filePaths[2]);
    String fileContent_datesList = await file_datesList.readAsString();
    if (fileContent_datesList != "") {
      datesList_greek = fileContent_datesList.split('<||>');
    } else {
      datesList_greek = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'datesList' don't exists");
    }
  }

  saveLists_greek();
}
