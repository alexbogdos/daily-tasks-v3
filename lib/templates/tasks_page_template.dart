// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/widgets/archivedTask.dart';
import 'package:daily_tasks_v3/widgets/custom_list_builder.dart';
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
      Key? key})
      : super(key: key);

  final List<Color> backgroundColors;
  final title;
  late List<String> tasksList;
  late List<String> archivedList;
  late List<String> datesList;
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
                                      date: index < widget.datesList.length
                                          ? widget.datesList[index]
                                          : "0/0",
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
