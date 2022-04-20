import 'package:daily_tasks_v3/templates/tasks_page_template.dart';
import 'package:daily_tasks_v3/widgets/archivedTask.dart';
import 'package:daily_tasks_v3/widgets/task_slidable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TasksListBuilder extends StatefulWidget {
  const TasksListBuilder({
    required this.tasksPage,
    required this.notifyParent,
    Key? key,
  }) : super(key: key);

  final TasksPage tasksPage;
  final Function notifyParent;

  @override
  State<TasksListBuilder> createState() => _TasksListBuilderState();
}

class _TasksListBuilderState extends State<TasksListBuilder> {
  late bool retrieved = false;

  @override
  Widget build(BuildContext context) {
    if (widget.tasksPage.retrieved == false) {
      // retrieveData(
      //     notifyParent: widget.notifyParent, tasksPage: widget.tasksPage);
      return customIndicator(
          function: retrieveData,
          notifyParent: widget.notifyParent,
          tasksPage: widget.tasksPage);
    } else {
      return ReorderableListView.builder(
        key: const PageStorageKey<String>('scrollController1'),
        scrollController: widget.tasksPage.scrollController1,
        scrollDirection: Axis.vertical,
        itemCount: widget.tasksPage.tasksList.length + 1,
        onReorder: (int oldIndex, int newIndex) {
          if (oldIndex < widget.tasksPage.tasksList.length &&
              newIndex < widget.tasksPage.tasksList.length) {
            widget.notifyParent(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final items = widget.tasksPage.tasksList.removeAt(oldIndex);
              widget.tasksPage.tasksList.insert(newIndex, items);
            });
            widget.tasksPage.saveLists();
          }
        },
        itemBuilder: (BuildContext context, int index) {
          if (index < widget.tasksPage.tasksList.length) {
            return TaskSlidable(
              context: context,
              index: index,
              key: ValueKey(index),
              text: widget.tasksPage.tasksList[index],
              tasksList: widget.tasksPage.tasksList,
              archivedList: widget.tasksPage.archivedList,
              datesList: widget.tasksPage.datesList,
              colors: widget.tasksPage.backgroundColors,
              notifyParent: widget.notifyParent,
              saveLists: widget.tasksPage.saveLists,
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
}

class ArchivedListBuilder extends StatefulWidget {
  const ArchivedListBuilder({
    Key? key,
    required this.tasksPage,
    required this.notifyParent,
  }) : super(key: key);

  final TasksPage tasksPage;
  final Function notifyParent;

  @override
  State<ArchivedListBuilder> createState() => _ArchivedListBuilderState();
}

class _ArchivedListBuilderState extends State<ArchivedListBuilder> {
  @override
  Widget build(BuildContext context) {
    if (widget.tasksPage.retrieved == false) {
      return customIndicator(
          function: retrieveData,
          notifyParent: widget.notifyParent,
          tasksPage: widget.tasksPage);
    } else {
      return ListView.builder(
        key: const PageStorageKey<String>('scrollController2'),
        controller: widget.tasksPage.scrollController2,
        scrollDirection: Axis.vertical,
        itemCount: widget.tasksPage.archivedList.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.tasksPage.archivedList.length) {
            return ArchivedTask(
              context: context,
              index: index,
              text: widget.tasksPage.archivedList[index],
              colors: widget.tasksPage.backgroundColors,
              date: index < widget.tasksPage.datesList.length
                  ? widget.tasksPage.datesList[index]
                  : "0/0",
            );
          } else {
            return const SizedBox(
              height: 10,
            );
          }
        },
      );
    }
  }
}

void retrieveData(
    {required Function notifyParent, required TasksPage tasksPage}) async {
  await tasksPage.retrieveLists();

  if (kDebugMode) {
    print("Data Retrieved");
  }

  notifyParent(() {
    tasksPage.reloadLists();
    tasksPage.retrieved = true;
    tasksPage.opened = true;
  });

  // Future.delayed(const Duration(milliseconds: 0), () async {});
}

Container customIndicator(
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
