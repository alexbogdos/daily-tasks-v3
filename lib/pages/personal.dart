import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage PagePersonal = TasksPage(
  title: "Personal",
  backgroundColors: [Color(0xffFFCB69), Color(0xffD08C60)],
  tasksList: tasksList_personal,
  archivedList: archivedList_personal,
  datesList: datesList_personal,
  saveLists: saveLists_personal,
);

List<String> tasksList_personal = [];

List<String> archivedList_personal = [];
List<String> datesList_personal = [];

void saveLists_personal () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_personal', tasksList_personal);
  await prefs.setStringList('archivedList_personal', archivedList_personal);
  await prefs.setStringList('datesList_personal', datesList_personal);

  print("Lists saved");
}

Future<void> retrieveLists_personal () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_personal')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_personal');
    if (_tasksList == null) {
    }else{
      tasksList_personal = _tasksList;
    }
  }else {
    print("tasksList_personal not in memory");
  }

  if (prefs.containsKey('archivedList_personal')) {
    final List<String>? _archivedList = prefs.getStringList('archivedList_personal');
    if (_archivedList == null) {
      archivedList_personal = [];
    }else{
      archivedList_personal.addAll(_archivedList);
    }
  }else {
    print("archivedList_personal not in memory");
  }

  if (prefs.containsKey('datesList_personal')) {
    final List<String>? _datesList = prefs.getStringList('datesList_personal');
    if (_datesList == null) {
      datesList_personal = [];
    }
    else{
      datesList_personal = _datesList;
    }
  }else {
    print("datesList_personal not in memory");
  }
}