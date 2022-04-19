import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:daily_tasks_v3/widgets/archivedTask.dart';
import 'package:daily_tasks_v3/widgets/task_slidable.dart';
import 'package:flutter/material.dart';

class TasksListBuilder extends StatelessWidget {
  const TasksListBuilder({
    required this.widget,
    required this.refreshParrent,
    Key? key,
  }) : super(key: key);

  final TasksPage widget;
  final Function refreshParrent;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.tasksList.length + 1,
      onReorder: (int oldIndex, int newIndex) {
        refreshParrent(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final items = widget.tasksList.removeAt(oldIndex);
          widget.tasksList.insert(newIndex, items);
        });
        widget.saveLists();
      },
      itemBuilder: (BuildContext context, int index) {
        if (index < widget.tasksList.length) {
          return TaskSlidable(
            context: context,
            index: index,
            key: ValueKey(index),
            text: widget.tasksList[index],
            tasksList: widget.tasksList,
            archivedList: widget.archivedList,
            datesList: widget.datesList,
            colors: widget.backgroundColors,
            notifyParent: refreshParrent,
            saveLists: widget.saveLists,
          );
        } else {
          return SizedBox(
            key: ValueKey(index),
            height: 100,
          );
        }
      },
    );
  }
}

class ArchivedListBuilder extends StatelessWidget {
  const ArchivedListBuilder({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final TasksPage widget;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: widget.archivedList.length + 1,
      itemBuilder: (context, index) {
        if (index < widget.archivedList.length) {
          return ArchivedTask(
            context: context,
            index: index,
            text: widget.archivedList[index],
            colors: widget.backgroundColors,
            date: index < widget.datesList.length
                ? widget.datesList[index]
                : "0/0",
          );
        } else {
          return const SizedBox(
            height: 20,
          );
        }
      },
    );
  }
}
