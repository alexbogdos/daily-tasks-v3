// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage PagePersonal = TasksPage(
  title: "Personal",
  backgroundColors: const [Color(0xffFFCB69), Color(0xffD08C60)],
  tasksList: tasksList_personal,
  archivedList: archivedList_personal,
  datesList: datesList_personal,
  saveLists: saveLists_personal,
);

List<String> tasksList_personal = [];

List<String> archivedList_personal = [];
List<String> datesList_personal = [];

void saveLists_personal() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_personal', tasksList_personal);
  await prefs.setStringList('archivedList_personal', archivedList_personal);
  await prefs.setStringList('datesList_personal', datesList_personal);

  if (kDebugMode) {
    print("Lists saved");
  }
}

Future<void> retrieveLists_personal() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_personal')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_personal');
    if (_tasksList != null) {
      tasksList_personal = _tasksList;
    }
  } else {
    if (kDebugMode) {
      print("tasksList_personal not in memory");
    }
  }

  if (prefs.containsKey('archivedList_personal')) {
    final List<String>? _archivedList =
        prefs.getStringList('archivedList_personal');
    if (_archivedList != null) {
      archivedList_personal = _archivedList;
    }
  } else {
    if (kDebugMode) {
      print("archivedList_personal not in memory");
    }
  }

  if (prefs.containsKey('datesList_personal')) {
    final List<String>? _datesList = prefs.getStringList('datesList_personal');
    if (_datesList != null) {
      datesList_personal = _datesList;
    }
  } else {
    if (kDebugMode) {
      print("datesList_personal not in memory");
    }
  }
}

Future<List<String>> getFilePath(String rootPath) async {
  String name = "Personal";

  if (!Directory("$rootPath/$name").existsSync()) {
    Directory("$rootPath/$name").createSync(recursive: true);
  }

  String filePath_tasksList = '$rootPath/$name/tasksList.txt';
  String filePath_archivedList = '$rootPath/$name/archivedList.txt';
  String filePath_datesList = '$rootPath/$name/datesList.txt';

  return [filePath_tasksList, filePath_archivedList, filePath_datesList];
}

Future<void> saveFile_personal(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  File file_tasksList = File(filePaths[0]);
  String string = "";
  if (kDebugMode) {
    print(
        "tasklist: $tasksList_personal  length: ${tasksList_personal.length}");
  }
  for (int index = 0; index < tasksList_personal.length; index++) {
    if (index < tasksList_personal.length - 1) {
      string += "${tasksList_personal[index]}<||>";
    } else {
      string += tasksList_personal[index];
    }
  }
  await file_tasksList.writeAsString(string);

  File file_archivedList = File(filePaths[1]);
  string = "";
  for (int index = 0; index < archivedList_personal.length; index++) {
    if (index < archivedList_personal.length - 1) {
      string += "${archivedList_personal[index]}<||>";
    } else {
      string += archivedList_personal[index];
    }
  }
  await file_archivedList.writeAsString(string);

  File file_datesList = File(filePaths[2]);
  string = "";
  for (int index = 0; index < datesList_personal.length; index++) {
    if (index < datesList_personal.length - 1) {
      string += "${datesList_personal[index]}<||>";
    } else {
      string += datesList_personal[index];
    }
  }
  await file_datesList.writeAsString(string);

  if (kDebugMode) {
    print("Lists Saved");
  }
}

Future<void> readFile_personal(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  if (await File(filePaths[0]).exists()) {
    File file_tasksList = File(filePaths[0]);
    String fileContent_tasksList = await file_tasksList.readAsString();
    if (fileContent_tasksList != "") {
      tasksList_personal = fileContent_tasksList.split('<||>');
    } else {
      tasksList_personal = [];
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
      archivedList_personal = fileContent_archivedList.split('<||>');
    } else {
      archivedList_personal = [];
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
      datesList_personal = fileContent_datesList.split('<||>');
    } else {
      datesList_personal = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'datesList' don't exists");
    }
  }

  saveLists_personal();
}
