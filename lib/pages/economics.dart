// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage pageEconomics = TasksPage(
  title: "Economics",
  backgroundColors: const [Color(0xffFAF4FB), Color(0xffFAF1D9)],
  tasksList: tasksList_economics,
  archivedList: archivedList_economics,
  datesList: datesList_economics,
  saveLists: saveLists_economics,
);

List<String> tasksList_economics = [];

List<String> archivedList_economics = [];
List<String> datesList_economics = [];

void saveLists_economics() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_economics', tasksList_economics);
  await prefs.setStringList('archivedList_economics', archivedList_economics);
  await prefs.setStringList('datesList_economics', datesList_economics);
}

Future<void> retrieveLists_economics() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_economics')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_economics');
    if (_tasksList != null) {
      tasksList_economics = _tasksList;
    }
  } else {
    if (kDebugMode) {
      print("tasksList_economics not in memory");
    }
  }

  if (prefs.containsKey('archivedList_economics')) {
    final List<String>? _archivedList =
        prefs.getStringList('archivedList_economics');
    if (_archivedList != null) {
      archivedList_economics.addAll(_archivedList);
    }
  } else {
    if (kDebugMode) {
      print("archivedList_economics not in memory");
    }
  }

  if (prefs.containsKey('datesList_economics')) {
    final List<String>? _datesList = prefs.getStringList('datesList_economics');
    if (_datesList != null) {
      datesList_economics = _datesList;
    }
  } else {
    if (kDebugMode) {
      print("datesList_economics not in memory");
    }
  }
}

Future<List<String>> getFilePath(String rootPath) async {
  String name = "Economics";

  if (!Directory("$rootPath/$name").existsSync()) {
    Directory("$rootPath/$name").createSync(recursive: true);
  }

  String filePathTasksList = '$rootPath/$name/tasksList.txt';
  String filePathArchivedList = '$rootPath/$name/archivedList.txt';
  String filePathDatesList = '$rootPath/$name/datesList.txt';

  return [filePathTasksList, filePathArchivedList, filePathDatesList];
}

Future<void> saveFile_economics(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  File fileTasksList = File(filePaths[0]);
  String string = "";
  if (kDebugMode) {
    print(
        "tasklist: $tasksList_economics  length: ${tasksList_economics.length}");
  }
  for (int index = 0; index < tasksList_economics.length; index++) {
    if (index < tasksList_economics.length - 1) {
      string += "${tasksList_economics[index]}<||>";
    } else {
      string += tasksList_economics[index];
    }
  }
  await fileTasksList.writeAsString(string);

  File fileArchivedList = File(filePaths[1]);
  string = "";
  for (int index = 0; index < archivedList_economics.length; index++) {
    if (index < archivedList_economics.length - 1) {
      string += "${archivedList_economics[index]}<||>";
    } else {
      string += archivedList_economics[index];
    }
  }
  await fileArchivedList.writeAsString(string);

  File fileDatesList = File(filePaths[2]);
  string = "";
  for (int index = 0; index < datesList_economics.length; index++) {
    if (index < datesList_economics.length - 1) {
      string += "${datesList_economics[index]}<||>";
    } else {
      string += datesList_economics[index];
    }
  }
  await fileDatesList.writeAsString(string);

  if (kDebugMode) {
    print("Lists Saved");
  }
}

Future<void> readFile_economics(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  if (await File(filePaths[0]).exists()) {
    File file_tasksList = File(filePaths[0]);
    String fileContent_tasksList = await file_tasksList.readAsString();
    if (fileContent_tasksList != "") {
      tasksList_economics = fileContent_tasksList.split('<||>');
    } else {
      tasksList_economics = [];
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
      archivedList_economics = fileContent_archivedList.split('<||>');
    } else {
      archivedList_economics = [];
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
      datesList_economics = fileContent_datesList.split('<||>');
    } else {
      datesList_economics = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'datesList' don't exists");
    }
  }

  saveLists_economics();
}
