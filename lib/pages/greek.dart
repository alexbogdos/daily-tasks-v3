import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage PageGreek = TasksPage(
  title: "Greek",
  backgroundColors: [Color(0xffFFD6A5), Color(0xffCAFFBF)],
  tasksList: tasksList_greek,
  archivedList: archivedList_greek,
  datesList: datesList_greek,
  saveLists: saveLists_greek,
);

List<String> tasksList_greek = [];

List<String> archivedList_greek = [];
List<String> datesList_greek = [];

void saveLists_greek () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_greek', tasksList_greek);
  await prefs.setStringList('archivedList_greek', archivedList_greek);
  await prefs.setStringList('datesList_greek', datesList_greek);
}

Future<void> retrieveLists_greek () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_greek')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_greek');
    if (_tasksList == null) {
    }else{
      tasksList_greek = _tasksList;
    }
  }else {
    print("tasksList_greek not in memory");
  }

  if (prefs.containsKey('archivedList_greek')) {
    final List<String>? _archivedList = prefs.getStringList('archivedList_greek');
    if (_archivedList == null) {
      archivedList_greek = [];
    }else{
      archivedList_greek.addAll(_archivedList);
    }
  }else {
    print("archivedList_greek not in memory");
  }

  if (prefs.containsKey('datesList_greek')) {
    final List<String>? _datesList = prefs.getStringList('datesList_greek');
    if (_datesList == null) {
      datesList_greek = [];
    }
    else{
      datesList_greek = _datesList;
    }
  }else {
    print("datesList_greek not in memory");
  }
}