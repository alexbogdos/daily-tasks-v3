// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage pageCoding = TasksPage(
  title: "Coding",
  backgroundColors: const [Color(0xffFAF4FB), Color(0xffFAF1D9)],
  tasksList: tasksList_coding,
  archivedList: archivedList_coding,
  datesList: datesList_coding,
  saveLists: saveLists_coding,
);

List<String> tasksList_coding = [];

List<String> archivedList_coding = [];
List<String> datesList_coding = [];

void saveLists_coding() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_coding', tasksList_coding);
  await prefs.setStringList('archivedList_coding', archivedList_coding);
  await prefs.setStringList('datesList_coding', datesList_coding);
}

Future<void> retrieveLists_coding() async {
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_coding')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_coding');
    if (_tasksList != null) {
      tasksList_coding = _tasksList;
    }
  } else {
    if (kDebugMode) {
      print("tasksList_coding not in memory");
    }
  }

  if (prefs.containsKey('archivedList_coding')) {
    final List<String>? _archivedList =
        prefs.getStringList('archivedList_coding');
    if (_archivedList != null) {
      archivedList_coding.addAll(_archivedList);
    }
  } else {
    if (kDebugMode) {
      print("archivedList_coding not in memory");
    }
  }

  if (prefs.containsKey('datesList_coding')) {
    final List<String>? _datesList = prefs.getStringList('datesList_coding');
    if (_datesList != null) {
      datesList_coding = _datesList;
    }
  } else {
    if (kDebugMode) {
      print("datesList_coding not in memory");
    }
  }
}

Future<List<String>> getFilePath(String rootPath) async {
  String name = "Coding";

  if (!Directory("$rootPath/$name").existsSync()) {
    Directory("$rootPath/$name").createSync(recursive: true);
  }

  String filePath_tasksList = '$rootPath/$name/tasksList.txt';
  String filePath_archivedList = '$rootPath/$name/archivedList.txt';
  String filePath_datesList = '$rootPath/$name/datesList.txt';

  return [filePath_tasksList, filePath_archivedList, filePath_datesList];
}

Future<void> saveFile_coding(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  File file_tasksList = File(filePaths[0]);
  String string = "";
  if (kDebugMode) {
    print("tasklist: $tasksList_coding  length: ${tasksList_coding.length}");
  }
  for (int index = 0; index < tasksList_coding.length; index++) {
    if (index < tasksList_coding.length - 1) {
      string += "${tasksList_coding[index]}<||>";
    } else {
      string += tasksList_coding[index];
    }
  }
  await file_tasksList.writeAsString(string);

  File file_archivedList = File(filePaths[1]);
  string = "";
  for (int index = 0; index < archivedList_coding.length; index++) {
    if (index < archivedList_coding.length - 1) {
      string += "${archivedList_coding[index]}<||>";
    } else {
      string += archivedList_coding[index];
    }
  }
  await file_archivedList.writeAsString(string);

  File file_datesList = File(filePaths[2]);
  string = "";
  for (int index = 0; index < datesList_coding.length; index++) {
    if (index < datesList_coding.length - 1) {
      string += "${datesList_coding[index]}<||>";
    } else {
      string += datesList_coding[index];
    }
  }
  await file_datesList.writeAsString(string);

  if (kDebugMode) {
    print("Lists Saved");
  }
}

Future<void> readFile_coding(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  if (await File(filePaths[0]).exists()) {
    File file_tasksList = File(filePaths[0]);
    String fileContent_tasksList = await file_tasksList.readAsString();
    if (fileContent_tasksList != "") {
      tasksList_coding = fileContent_tasksList.split('<||>');
    } else {
      tasksList_coding = [];
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
      archivedList_coding = fileContent_archivedList.split('<||>');
    } else {
      archivedList_coding = [];
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
      datesList_coding = fileContent_datesList.split('<||>');
    } else {
      datesList_coding = [];
    }
  } else {
    if (kDebugMode) {
      print("File 'datesList' don't exists");
    }
  }

  saveLists_coding();
}
