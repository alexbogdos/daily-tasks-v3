import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

TasksPage PageCoding = TasksPage(
  title: "Coding",
  backgroundColors: [Color(0xffFFADAD), Color(0xffFFC6FF)],
  tasksList: tasksList_coding,
  archivedList: archivedList_coding,
  datesList: datesList_coding,
  saveLists: saveLists_coding,
);

List<String> tasksList_coding = [];

List<String> archivedList_coding = [];
List<String> datesList_coding = [];

void saveLists_coding () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  await prefs.setStringList('tasksList_coding', tasksList_coding);
  await prefs.setStringList('archivedList_coding', archivedList_coding);
  await prefs.setStringList('datesList_coding', datesList_coding);
}

Future<void> retrieveLists_coding () async{
  // Obtain shared preferences.
  final prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('tasksList_coding')) {
    final List<String>? _tasksList = prefs.getStringList('tasksList_coding');
    if (_tasksList == null) {
    }else{
      tasksList_coding = _tasksList;
    }
  }else {
    print("tasksList_coding not in memory");
  }

  if (prefs.containsKey('archivedList_coding')) {
    final List<String>? _archivedList = prefs.getStringList('archivedList_coding');
    if (_archivedList == null) {
      archivedList_coding = [];
    }else{
      archivedList_coding.addAll(_archivedList);
    }
  }else {
    print("archivedList_coding not in memory");
  }

  if (prefs.containsKey('datesList_coding')) {
    final List<String>? _datesList = prefs.getStringList('datesList_coding');
    if (_datesList == null) {
      datesList_coding = [];
    }
    else{
      datesList_coding = _datesList;
    }
  }else {
    print("datesList_coding not in memory");
  }
}