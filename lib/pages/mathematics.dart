// ignore_for_file: non_constant_identifier_names

import 'package:daily_tasks_v3/templates/tasks_page_functions.dart';
import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';

TasksPage PageMathematics = TasksPage(
  title: "Mathematics",
  backgroundColors: const [Color(0xffFAF4FB), Color(0xffFAF1D9)],
  tasksList: tasksList_mathematics,
  archivedList: archivedList_mathematics,
  datesList: datesList_mathematics,
  saveLists: saveLists_mathematics,
);

List<String> tasksList_mathematics = [];
List<String> archivedList_mathematics = [];
List<String> datesList_mathematics = [];

void reload_mathematics() {
  PageMathematics.tasksList = tasksList_mathematics;
  PageMathematics.archivedList = archivedList_mathematics;
  PageMathematics.datesList = datesList_mathematics;
}

String key_mathematics = 'mathematics';

void saveLists_mathematics() {
  saveLists(
      tasksList: tasksList_mathematics,
      archivedList: archivedList_mathematics,
      datesList: datesList_mathematics,
      key: key_mathematics);
}

Future<void> retrieveLists_mathematics() async {
  List<List<String>> _lists = await retrieveLists(
      tasksList: tasksList_mathematics,
      archivedList: archivedList_mathematics,
      datesList: datesList_mathematics,
      key: key_mathematics);

  tasksList_mathematics = _lists[0];
  archivedList_mathematics = _lists[1];
  datesList_mathematics = _lists[2];
}

Future<void> saveFile_mathematics(String rootPath) async {
  saveFile(
      tasksList: tasksList_mathematics,
      archivedList: archivedList_mathematics,
      datesList: datesList_mathematics,
      key: key_mathematics,
      rootPath: rootPath);
}

Future<void> readFile_mathematics(String rootPath) async {
  List<List<String>> _lists = await readFile(
      tasksList: tasksList_mathematics,
      archivedList: archivedList_mathematics,
      datesList: datesList_mathematics,
      key: key_mathematics,
      rootPath: rootPath);

  tasksList_mathematics = _lists[0];
  archivedList_mathematics = _lists[1];
  datesList_mathematics = _lists[2];
}
