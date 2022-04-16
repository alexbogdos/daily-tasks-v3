// ignore_for_file: non_constant_identifier_names

import 'package:daily_tasks_v3/templates/tasks_page_functions.dart';
import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';

TasksPage PagePersonal = TasksPage(
  title: "Personal",
  backgroundColors: const [Color(0xffFAF4FB), Color(0xffFAF1D9)],
  tasksList: tasksList_personal,
  archivedList: archivedList_personal,
  datesList: datesList_personal,
  saveLists: saveLists_personal,
);

List<String> tasksList_personal = [];
List<String> archivedList_personal = [];
List<String> datesList_personal = [];

String key_personal = 'personal';

void saveLists_personal() {
  saveLists(
      tasksList: tasksList_personal,
      archivedList: archivedList_personal,
      datesList: datesList_personal,
      key: key_personal);
}

Future<void> retrieveLists_personal() async {
  List<List<String>> _lists = await retrieveLists(
      tasksList: tasksList_personal,
      archivedList: archivedList_personal,
      datesList: datesList_personal,
      key: key_personal);

  tasksList_personal = _lists[0];
  archivedList_personal = _lists[1];
  datesList_personal = _lists[2];
}

Future<void> saveFile_personal(String rootPath) async {
  saveFile(
      tasksList: tasksList_personal,
      archivedList: archivedList_personal,
      datesList: datesList_personal,
      key: key_personal,
      rootPath: rootPath);
}

Future<void> readFile_personal(String rootPath) async {
  List<List<String>> _lists = await readFile(
      tasksList: tasksList_personal,
      archivedList: archivedList_personal,
      datesList: datesList_personal,
      key: key_personal,
      rootPath: rootPath);

  tasksList_personal = _lists[0];
  archivedList_personal = _lists[1];
  datesList_personal = _lists[2];
}
