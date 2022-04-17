// ignore_for_file: non_constant_identifier_names

import 'package:daily_tasks_v3/templates/tasks_page_functions.dart';
import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';

TasksPage PageEconomics = TasksPage(
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

void reload_economics() {
  PageEconomics.tasksList = tasksList_economics;
  PageEconomics.archivedList = archivedList_economics;
  PageEconomics.datesList = datesList_economics;
}

String key_economics = 'economics';

void saveLists_economics() {
  saveLists(
      tasksList: tasksList_economics,
      archivedList: archivedList_economics,
      datesList: datesList_economics,
      key: key_economics);
}

Future<void> retrieveLists_economics() async {
  List<List<String>> _lists = await retrieveLists(
      tasksList: tasksList_economics,
      archivedList: archivedList_economics,
      datesList: datesList_economics,
      key: key_economics);

  tasksList_economics = _lists[0];
  archivedList_economics = _lists[1];
  datesList_economics = _lists[2];
}

Future<void> saveFile_economics(String rootPath) async {
  saveFile(
      tasksList: tasksList_economics,
      archivedList: archivedList_economics,
      datesList: datesList_economics,
      key: key_economics,
      rootPath: rootPath);
}

Future<void> readFile_economics(String rootPath) async {
  List<List<String>> _lists = await readFile(
      tasksList: tasksList_economics,
      archivedList: archivedList_economics,
      datesList: datesList_economics,
      key: key_economics,
      rootPath: rootPath);

  tasksList_economics = _lists[0];
  archivedList_economics = _lists[1];
  datesList_economics = _lists[2];
}
