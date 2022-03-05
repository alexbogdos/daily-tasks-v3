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