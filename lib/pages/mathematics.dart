import 'dart:io';

import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage PageMathematics = TasksPage(
  title: "Mathematics",
  backgroundColors: [Color(0xffFFC6FF), Color(0xffFDFFB6)],
  tasksList: tasksList_mathematics,
  archivedList: archivedList_mathematics,
  datesList: datesList_mathematics,
  saveLists: saveLists_mathematics,
);

List<String> tasksList_mathematics = [];

List<String> archivedList_mathematics = [];
List<String> datesList_mathematics = [];

void saveLists_mathematics () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_mathematics', tasksList_mathematics);
  await prefs.setStringList('archivedList_mathematics', archivedList_mathematics);
  await prefs.setStringList('datesList_mathematics', datesList_mathematics);
  print("saved lists");
}

Future<void> retrieveLists_mathematics () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_mathematics')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_mathematics');
    if (_tasksList == null) {
    }else{
      tasksList_mathematics = _tasksList;
    }
  }else {
    print("tasksList_mathematics not in memory");
  }

  if (prefs.containsKey('archivedList_mathematics')) {
    final List<String>? _archivedList = prefs.getStringList('archivedList_mathematics');
    if (_archivedList == null) {
      archivedList_mathematics = [];
    }else{
      archivedList_mathematics.addAll(_archivedList);
    }
  }else {
    print("archivedList_mathematics not in memory");
  }

  if (prefs.containsKey('datesList_mathematics')) {
    final List<String>? _datesList = prefs.getStringList('datesList_mathematics');
    if (_datesList == null) {
      datesList_mathematics = [];
    }
    else{
      datesList_mathematics = _datesList;
    }
  }else {
    print("datesList_mathematics not in memory");
  }
}


Future<List<String>> getFilePath(String rootPath) async {
  String name = "Mathematics";

  if (!Directory("$rootPath/$name").existsSync()) {
    Directory("$rootPath/$name").createSync(recursive: true);
  }

  String filePath_tasksList = '$rootPath/$name/tasksList.txt';
  String filePath_archivedList = '$rootPath/$name/archivedList.txt';
  String filePath_datesList = '$rootPath/$name/datesList.txt';

  return [filePath_tasksList, filePath_archivedList, filePath_datesList];
}

Future<void> saveFile_mathematics(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  File file_tasksList =  File(filePaths[0]);
  String string = "";
  print("tasklist: $tasksList_mathematics  length: ${tasksList_mathematics.length}");
  for (int index = 0; index < tasksList_mathematics.length; index++) {
    if (index < tasksList_mathematics.length - 1) {
      string += "${tasksList_mathematics[index]}\n";
    } else {
      string += "${tasksList_mathematics[index]}";
    }
  }
  await file_tasksList.writeAsString(string);

  File file_archivedList = File(filePaths[1]);
  string = "";
  for (int index = 0; index < archivedList_mathematics.length; index++) {
    if (index < archivedList_mathematics.length - 1) {
      string += "${archivedList_mathematics[index]}\n";
    } else {
      string += "${archivedList_mathematics[index]}";
    }
  }
  await file_archivedList.writeAsString(string);

  File file_datesList = File(filePaths[2]);
  string = "";
  for (int index = 0; index < datesList_mathematics.length; index++) {
    if (index < datesList_mathematics.length - 1) {
      string += "${datesList_mathematics[index]}\n";
    } else {
      string += "${datesList_mathematics[index]}";
    }
  }
  await file_datesList.writeAsString(string);

  print("Lists Saved");
}

Future<void> readFile_mathematics(String rootPath) async {
  List<String> filePaths = await getFilePath(rootPath);

  if (await File(filePaths[0]).exists()) {
    File file_tasksList = File(filePaths[0]);
    String fileContent_tasksList = await file_tasksList.readAsString();
    if (fileContent_tasksList != "") {
      tasksList_mathematics = await fileContent_tasksList.split('\n');
    }
  } else {
    print("File 'tasksList' don't exists");
  }

  if (await File(filePaths[1]).exists()) {
    File file_archivedList = File(filePaths[1]);
    String fileContent_archivedList = await file_archivedList.readAsString();
    if (fileContent_archivedList != "") {
      archivedList_mathematics = await fileContent_archivedList.split('\n');
    }
  } else {
    print("File 'archivedList' don't exists");
  }

  if (await File(filePaths[2]).exists()) {
    File file_datesList = File(filePaths[2]);
    String fileContent_datesList = await file_datesList.readAsString();
    if (fileContent_datesList != "") {
      datesList_mathematics = await fileContent_datesList.split('\n');
    }
  } else {
    print("File 'datesList' don't exists");
  }

  saveLists_mathematics();
}