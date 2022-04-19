// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/widgets/custom_list_builders.dart';
import 'package:daily_tasks_v3/widgets/custom_tabbar.dart';
import 'package:daily_tasks_v3/widgets/new_task_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class TasksPage extends StatefulWidget {
  TasksPage(
      {required this.title,
      required this.backgroundColors,
      required this.tasksList,
      required this.archivedList,
      required this.datesList,
      required this.saveLists,
      required this.retrieveLists,
      required this.reloadLists,
      Key? key})
      : super(key: key);

  final title;
  final List<Color> backgroundColors;
  late List<String> tasksList;
  late List<String> archivedList;
  late List<String> datesList;
  final Function saveLists;
  final Function retrieveLists;
  final Function reloadLists;

  late bool retrieved = false;

  late ScrollController scrollController1 = ScrollController();
  late ScrollController scrollController2 = ScrollController();

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void dispose() {
    // widget.scrollController1.dispose();
    // widget.scrollController2.dispose();
    super.dispose();
  }

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
                        const CustomBackButton(),
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
                                    controller: widget.scrollController1,
                                    thickness: 8,
                                    interactive: true,
                                    radius: const Radius.circular(5),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                      ),

                                      // Tasks List
                                      child: TasksListBuilder(
                                        tasksPage: widget,
                                        notifyParent: refresh,
                                      ),
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
                                controller: widget.scrollController2,
                                thickness: 8,
                                interactive: true,
                                radius: const Radius.circular(5),

                                // Archived Tasks List
                                child: ArchivedListBuilder(
                                  tasksPage: widget,
                                  notifyParent: refresh,
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
    if (mounted == false) {
      return;
    }
    setState(() {
      if (kDebugMode) {
        print("refreshed");
      }
      function();
    });
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Center(
              child: Text(
                "Back",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: const Color(0xFF6d69f0).withOpacity(0.6),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            style: TextButton.styleFrom(
                backgroundColor: Colors.transparent,
                primary: const Color(0xFF6d69f0).withOpacity(0.6)),
          ),
        ),
      ],
    );
  }
}
