import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:flutter/material.dart';

Container customTasksPageIndicator(
    {required Function function,
    required Function notifyParent,
    required TasksPage tasksPage}) {
  const Color backgroundColor = Color(0xFFf0f1f2);
  const Color titleColor = Color(0xFF343434);
  const Color buttonColor = Color(0xFFfdfdfd);

  function(notifyParent: notifyParent, tasksPage: tasksPage);
  return Container(
    color: backgroundColor,
    child: const Center(
        child: CircularProgressIndicator(
      backgroundColor: buttonColor,
      color: titleColor,
    )),
  );
}

Container customSettingsIndicator({
  required Function function,
}) {
  const Color backgroundColor = Color(0xFFf0f1f2);
  const Color titleColor = Color(0xFF343434);
  const Color buttonColor = Color(0xFFfdfdfd);

  function();

  return Container(
    color: backgroundColor,
    child: const Center(
        child: CircularProgressIndicator(
      backgroundColor: buttonColor,
      color: titleColor,
    )),
  );
}
