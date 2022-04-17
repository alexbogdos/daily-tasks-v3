import 'package:daily_tasks_v3/widgets/task_slidable.dart';
import 'package:flutter/material.dart';

class CustomListBuilder extends StatelessWidget {
  const CustomListBuilder({
    required this.tasksList,
    required this.archivedList,
    required this.datesList,
    required this.refreshParrent,
    required this.backgroundColors,
    required this.saveLists,
    Key? key,
  }) : super(key: key);

  final List<String> tasksList;
  final List<String> archivedList;
  final List<String> datesList;
  final List<Color> backgroundColors;
  final Function refreshParrent;
  final Function saveLists;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: tasksList.length + 1,
      onReorder: (int oldIndex, int newIndex) {
        refreshParrent(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final items = tasksList.removeAt(oldIndex);
          tasksList.insert(newIndex, items);
        });
        saveLists();
      },
      itemBuilder: (BuildContext context, int index) {
        if (index < tasksList.length) {
          return TaskSlidable(
            context: context,
            index: index,
            key: ValueKey(index),
            text: tasksList[index],
            tasksList: tasksList,
            archivedList: archivedList,
            datesList: datesList,
            colors: backgroundColors,
            notifyParent: refreshParrent,
            saveLists: saveLists,
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
