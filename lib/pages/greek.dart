// ignore_for_file: non_constant_identifier_names

import 'package:daily_tasks_v3/templates/tasks_page_functions.dart';
import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';

TasksPage PageGreek = TasksPage(
  title: "Greek",
  backgroundColors: const [Color(0xffFAF4FB), Color(0xffFAF1D9)],
  tasksList: tasksList_greek,
  archivedList: archivedList_greek,
  datesList: datesList_greek,
  saveLists: saveLists_greek,
);

List<String> tasksList_greek = [];
List<String> archivedList_greek = [];
List<String> datesList_greek = [];

void reload_greek() {
  PageGreek.tasksList = tasksList_greek;
  PageGreek.archivedList = archivedList_greek;
  PageGreek.datesList = datesList_greek;
}

String key_greek = 'greek';

void saveLists_greek() {
  saveLists(
      tasksList: tasksList_greek,
      archivedList: archivedList_greek,
      datesList: datesList_greek,
      key: key_greek);
}

Future<void> retrieveLists_greek() async {
  List<List<String>> _lists = await retrieveLists(
      tasksList: tasksList_greek,
      archivedList: archivedList_greek,
      datesList: datesList_greek,
      key: key_greek);

  tasksList_greek = _lists[0];
  archivedList_greek = _lists[1];
  datesList_greek = _lists[2];
}

Future<void> saveFile_greek(String rootPath) async {
  saveFile(
      tasksList: tasksList_greek,
      archivedList: archivedList_greek,
      datesList: datesList_greek,
      key: key_greek,
      rootPath: rootPath);
}

Future<void> readFile_greek(String rootPath) async {
  List<List<String>> _lists = await readFile(
      tasksList: tasksList_greek,
      archivedList: archivedList_greek,
      datesList: datesList_greek,
      key: key_greek,
      rootPath: rootPath);

  tasksList_greek = _lists[0];
  archivedList_greek = _lists[1];
  datesList_greek = _lists[2];
}
