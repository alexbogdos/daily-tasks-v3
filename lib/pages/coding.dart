// ignore_for_file: non_constant_identifier_names

import 'package:daily_tasks_v3/templates/tasks_page_functions.dart';
import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';

TasksPage PageCoding = TasksPage(
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

void reload_coding() {
  PageCoding.tasksList = tasksList_coding;
  PageCoding.archivedList = archivedList_coding;
  PageCoding.datesList = datesList_coding;
}

String key_coding = 'coding';

void saveLists_coding() {
  saveLists(
      tasksList: tasksList_coding,
      archivedList: archivedList_coding,
      datesList: datesList_coding,
      key: key_coding);
}

Future<void> retrieveLists_coding() async {
  List<List<String>> _lists = await retrieveLists(
      tasksList: tasksList_coding,
      archivedList: archivedList_coding,
      datesList: datesList_coding,
      key: key_coding);

  tasksList_coding = _lists[0];
  archivedList_coding = _lists[1];
  datesList_coding = _lists[2];
}

Future<void> saveFile_coding(String rootPath) async {
  saveFile(
      tasksList: tasksList_coding,
      archivedList: archivedList_coding,
      datesList: datesList_coding,
      key: key_coding,
      rootPath: rootPath);
}

Future<void> readFile_coding(String rootPath) async {
  List<List<String>> _lists = await readFile(
      tasksList: tasksList_coding,
      archivedList: archivedList_coding,
      datesList: datesList_coding,
      key: key_coding,
      rootPath: rootPath);

  tasksList_coding = _lists[0];
  archivedList_coding = _lists[1];
  datesList_coding = _lists[2];
}
