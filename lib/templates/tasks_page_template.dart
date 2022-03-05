import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/widgets/taskSlidable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/archivedTask.dart';
import '../widgets/editTask_dialog.dart';

class TasksPage extends StatefulWidget {
  final List<Color> backgroundColors;
  final title;
  final List<String> tasksList;
  final List<String> archivedList;
  final List<String> datesList;
  final saveLists;

  const TasksPage(
      {required this.title,
      required this.backgroundColors,
      required this.tasksList,
      required this.archivedList,
      required this.datesList,
      required this.saveLists,
      Key? key})
      : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    Color button_color = widget.backgroundColors[0].withOpacity(0.86);
    Color button_text_color = Colors.white;

    return Scaffold(
      backgroundColor: widget.backgroundColors[0],
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.backgroundColors,
                stops: [0.0, 1.0],
              ),
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
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                ),
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
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              shadows: [
                                Shadow(
                                  blurRadius: 8.0,
                                  color: Colors.black12,
                                  offset: Offset(-4.0, 4.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TabBar(
                      labelColor: Colors.white,
                      labelStyle: GoogleFonts.poppins(
                          fontSize: 22, fontWeight: FontWeight.w600),
                      indicatorColor: Colors.white70,
                      tabs: [
                        Tab(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Tasks"),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 40,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    '${widget.tasksList.length}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: widget.backgroundColors[1]
                                    .withOpacity(0.34),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        )),
                        Tab(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("History"),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 40,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    '${widget.archivedList.length}',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.9),
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: widget.backgroundColors[1]
                                    .withOpacity(0.34),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(5, 10, 5, 0),
                            child: Stack(
                              alignment: AlignmentDirectional(0, 1),
                              children: [
                                Scrollbar(
                                  thickness: 6,
                                  interactive: true,
                                  radius: Radius.circular(5),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      canvasColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: ReorderableListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: widget.tasksList.length + 1,
                                      itemBuilder: (context, index) => index <
                                              widget.tasksList.length
                                          ? TaskSlidable(
                                              context: context,
                                              index: index,
                                              key: ValueKey(index),
                                              text: widget.tasksList[index],
                                              tasksList: widget.tasksList,
                                              archivedList: widget.archivedList,
                                              datesList: widget.datesList,
                                              colors: widget.backgroundColors,
                                              notifyParent: refresh,
                                              saveLists: widget.saveLists,
                                            )
                                          : SizedBox(
                                              key: ValueKey(index),
                                              height: 100,
                                            ),
                                      onReorder: (int oldIndex, int newIndex) {
                                        setState(() {
                                          if (newIndex > oldIndex) {
                                            newIndex -= 1;
                                          }
                                          final items = widget.tasksList
                                              .removeAt(oldIndex);
                                          widget.tasksList
                                              .insert(newIndex, items);
                                        });
                                        widget.saveLists();
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 30),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      color: button_color,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add_rounded,
                                                color: button_text_color,
                                                size: 24,
                                              ),
                                              SizedBox(
                                                width: 4,
                                              ),
                                              AutoSizeText(
                                                'New Task',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  color: button_text_color,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            widget.tasksList.add("New task");
                                            EditTaskDialog(
                                              context: context,
                                              isNew: true,
                                              colors: widget.backgroundColors,
                                              index:
                                                  widget.tasksList.length - 1,
                                              tasksList: widget.tasksList,
                                              notifyParent: () {
                                                setState(() {});
                                              },
                                            ).Show().then((value) =>
                                                refresh(widget.saveLists));
                                          },
                                          onLongPress: () {
                                            widget.tasksList
                                                .insert(0, "New task");
                                            EditTaskDialog(
                                              context: context,
                                              isNew: true,
                                              colors: widget.backgroundColors,
                                              index: 0,
                                              tasksList: widget.tasksList,
                                              notifyParent: () {
                                                setState(() {});
                                              },
                                            ).Show().then((value) =>
                                                refresh(widget.saveLists));
                                          },
                                          child: Text(''),
                                          style: TextButton.styleFrom(
                                            primary: Colors.white12,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
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
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Scrollbar(
                              thickness: 6,
                              interactive: true,
                              radius: Radius.circular(5),
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: widget.archivedList.length,
                                itemBuilder: (context, index) => ArchivedTask(
                                  context: context,
                                  index: index,
                                  text: widget.archivedList[index],
                                  colors: widget.backgroundColors,
                                  date: widget.datesList[index],
                                ),
                              ),
                            ),
                          ),
                        ],
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

  void refresh(function) {
    setState(() {
      print("refreshed");
      function();
    });
  }
}
