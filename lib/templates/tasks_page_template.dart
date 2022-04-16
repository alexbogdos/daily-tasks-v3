// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/widgets/archivedTask.dart';
import 'package:daily_tasks_v3/widgets/edittask_dialog.dart';
import 'package:daily_tasks_v3/widgets/task_slidable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TasksPage extends StatefulWidget {
  const TasksPage(
      {required this.title,
      required this.backgroundColors,
      required this.tasksList,
      required this.archivedList,
      required this.datesList,
      required this.saveLists,
      Key? key})
      : super(key: key);

  final List<Color> backgroundColors;
  final title;
  final List<String> tasksList;
  final List<String> archivedList;
  final List<String> datesList;
  final saveLists;
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf0f1f2),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFf0f1f2),
            ),
            child: DefaultTabController(
              length: 2,
              initialIndex: 0,
              child: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, top: 4.0),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Center(
                                  child: Text(
                                    "Back",
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      color: const Color(0xFF6d69f0)
                                          .withOpacity(0.6),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    primary: const Color(0xFF6d69f0)
                                        .withOpacity(0.6)),
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: AutoSizeText(
                            '${widget.title}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              color: const Color(0xFF343434),
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color:
                                      const Color(0xFF343434).withOpacity(0.1),
                                  offset: const Offset(5.0, 5.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTabBar(
                        tasksListLength: widget.tasksList.length,
                        archivedListLength: widget.archivedList.length),
                    Expanded(
                      child: RepaintBoundary(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5, 10, 5, 0),
                              child: Stack(
                                alignment: const AlignmentDirectional(0, 1),
                                children: [
                                  Scrollbar(
                                    thickness: 8,
                                    interactive: true,
                                    radius: const Radius.circular(5),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),

                                      // Tasks List
                                      child: CustomListBuilder(
                                          tasksList: widget.tasksList,
                                          archivedList: widget.archivedList,
                                          datesList: widget.datesList,
                                          refreshParrent: refresh,
                                          backgroundColors:
                                              widget.backgroundColors,
                                          saveLists: widget.saveLists),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 30),
                                    child: NewTaskButton(
                                        tasksList: widget.tasksList,
                                        refreshParrent: refresh,
                                        saveLists: widget.saveLists),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 10, 0, 0),
                              child: Scrollbar(
                                thickness: 8,
                                interactive: true,
                                radius: const Radius.circular(5),

                                // Archived Tasks List
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: widget.archivedList.length,
                                  itemBuilder: (context, index) {
                                    return ArchivedTask(
                                      context: context,
                                      index: index,
                                      text: widget.archivedList[index],
                                      colors: widget.backgroundColors,
                                      date: widget.datesList[index],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void refresh(Function function) {
    setState(() {
      if (kDebugMode) {
        print("refreshed");
      }
      function();
    });
  }
}

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

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({
    required this.tasksList,
    required this.refreshParrent,
    required this.saveLists,
    Key? key,
  }) : super(key: key);

  final List<String> tasksList;
  final Function refreshParrent;
  final Function saveLists;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: const Color(0xFF6d69f0),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF343434).withOpacity(0.1),
            blurRadius: 6.0,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_rounded,
                  color: Color(0xFFFFFFFF),
                  size: 24,
                ),
                const SizedBox(
                  width: 4,
                ),
                AutoSizeText(
                  'New Task',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              tasksList.add("New task");
              EditTaskDialog(
                context: context,
                isNew: true,
                index: tasksList.length - 1,
                tasksList: tasksList,
                notifyParent: () {},
              ).show().then((value) => refreshParrent(saveLists));
            },
            onLongPress: () {
              tasksList.insert(0, "New task");
              EditTaskDialog(
                context: context,
                isNew: true,
                index: 0,
                tasksList: tasksList,
                notifyParent: () {
                  // refreshParrent;
                },
              ).show().then((value) => refreshParrent(saveLists));
            },
            child: const Text(''),
            style: TextButton.styleFrom(
              primary: Colors.white12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    required this.tasksListLength,
    required this.archivedListLength,
    Key? key,
  }) : super(key: key);

  final int tasksListLength;
  final int archivedListLength;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: const Color(0xFF343434),
      labelStyle:
          GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
      indicatorColor: const Color(0xFF343434).withOpacity(0.8),
      tabs: [
        Tab(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Tasks"),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 40,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '$tasksListLength',
                    style: TextStyle(
                      color: const Color(0xFF343434).withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF343434).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ],
        )),
        Tab(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("History"),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 40,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '$archivedListLength',
                    style: TextStyle(
                      color: const Color(0xFF343434).withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF343434).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ],
        )),
      ],
    );
  }
}
