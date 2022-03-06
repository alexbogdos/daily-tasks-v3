import 'dart:io';

import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage PageEconomics = TasksPage(
  title: "Economics",
  backgroundColors: [Color(0xffBDB2FF), Color(0xffFFFFFC)],
  tasksList: tasksList_economics,
  archivedList: archivedList_economics,
  datesList: datesList_economics,
  saveLists: saveLists_economics,
);

List<String> tasksList_economics = [];

List<String> archivedList_economics = [];
List<String> datesList_economics = [];

void saveLists_economics () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_economics', tasksList_economics);
  await prefs.setStringList('archivedList_economics', archivedList_economics);
  await prefs.setStringList('datesList_economics', datesList_economics);
}

Future<void> retrieveLists_economics () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_economics')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_economics');
    if (_tasksList == null) {
    }else{
      tasksList_economics = _tasksList;
    }
  }else {
    print("tasksList_economics not in memory");
  }

  if (prefs.containsKey('archivedList_economics')) {
    final List<String>? _archivedList = prefs.getStringList('archivedList_economics');
    if (_archivedList == null) {
      archivedList_economics = [];
    }else{
      archivedList_economics.addAll(_archivedList);
    }
  }else {
    print("archivedList_economics not in memory");
  }

  if (prefs.containsKey('datesList_economics')) {
    final List<String>? _datesList = prefs.getStringList('datesList_economics');
    if (_datesList == null) {
      datesList_economics = [];
    }
    else{
      datesList_economics = _datesList;
    }
  }else {
    print("datesList_economics not in memory");
  }
}

Future<List<String>> getFilePath(String rootPath) async {
  String name = "Economics";

  if (!Directory("$rootPath/$name").existsSync()) {
    Directory("$rootPath/$name").createSync(recursive: true);
  }

  String filePath_tasksList = '$rootPath/$name/tasksList.txt';
  String filePath_archivedList = '$rootPath/$name/archivedList.txt';
  String filePath_datesList = '$rootPath/$name/datesList.txt';

  return [filePath_tasksList, filePath_archivedList, filePath_datesList];
}

Future<void> saveFile_economics(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  File file_tasksList =  File(filePaths[0]);
  String string = "";
  print("tasklist: $tasksList_economics  length: ${tasksList_economics.length}");
  for (int index = 0; index < tasksList_economics.length; index++) {
    if (index < tasksList_economics.length - 1) {
      string += "${tasksList_economics[index]}\n";
    } else {
      string += "${tasksList_economics[index]}";
    }
  }
  await file_tasksList.writeAsString(string);

  File file_archivedList = File(filePaths[1]);
  string = "";
  for (int index = 0; index < archivedList_economics.length; index++) {
    if (index < archivedList_economics.length - 1) {
      string += "${archivedList_economics[index]}\n";
    } else {
      string += "${archivedList_economics[index]}";
    }
  }
  await file_archivedList.writeAsString(string);

  File file_datesList = File(filePaths[2]);
  string = "";
  for (int index = 0; index < datesList_economics.length; index++) {
    if (index < datesList_economics.length - 1) {
      string += "${datesList_economics[index]}\n";
    } else {
      string += "${datesList_economics[index]}";
    }
  }
  await file_datesList.writeAsString(string);

  print("Lists Saved");
}

Future<void> readFile_economics(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  if (await File(filePaths[0]).exists()) {
    File file_tasksList = File(filePaths[0]);
    String fileContent_tasksList = await file_tasksList.readAsString();
    if (fileContent_tasksList != "") {
      tasksList_economics = await fileContent_tasksList.split('\n');
    }
  } else {
    print("File 'tasksList' don't exists");
  }

  if (await File(filePaths[1]).exists()) {
    File file_archivedList = File(filePaths[1]);
    String fileContent_archivedList = await file_archivedList.readAsString();
    if (fileContent_archivedList != "") {
      archivedList_economics = await fileContent_archivedList.split('\n');
    }
  } else {
    print("File 'archivedList' don't exists");
  }

  if (await File(filePaths[2]).exists()) {
    File file_datesList = File(filePaths[2]);
    String fileContent_datesList = await file_datesList.readAsString();
    if (fileContent_datesList != "") {
      datesList_economics = await fileContent_datesList.split('\n');
    }
  } else {
    print("File 'datesList' don't exists");
  }

  saveLists_economics();
}