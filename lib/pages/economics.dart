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