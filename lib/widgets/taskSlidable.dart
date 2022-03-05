import 'package:daily_tasks_v3/widgets/editTask_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskSlidable extends StatefulWidget {
  final BuildContext context;
  final int index;
  final String text;
  final List<Color> colors;
  final List<String> tasksList;
  final List<String> archivedList;
  final List<String> datesList;
  final notifyParent;
  final saveLists;

  const TaskSlidable(
      {required this.context,
      required this.index,
      required this.text,
      required this.colors,
      required this.tasksList,
      required this.archivedList,
      required this.notifyParent,
      required this.datesList,
      required this.saveLists,
      Key? key})
      : super(key: key);

  @override
  State<TaskSlidable> createState() => _TaskSlidableState();
}

class _TaskSlidableState extends State<TaskSlidable> {
  void archive(BuildContext context) {
    print(
        "archive task:\n  index: ${widget.index}\n  string: '${widget.text}'");

    widget.notifyParent(_archiveNotify);
  }

  void _archiveNotify() {
    setState(() {
      widget.tasksList.removeAt(widget.index);
      widget.archivedList.insert(0, widget.text);
      widget.datesList
          .insert(0, "${DateTime.now().day}/${DateTime.now().month}");
      widget.saveLists();
    });
  }

  void edit(BuildContext context) {
    print("edit task:\n  index: ${widget.index}\n  string: '${widget.text}'");

    EditTaskDialog(
      context: context,
      isNew: false,
      colors: widget.colors,
      index: widget.index,
      tasksList: widget.tasksList,
      notifyParent: () {
        setState(() {});
      },
    ).Show().then((value) => widget.notifyParent(widget.saveLists));
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // The start action pane is the one at the left or the top side.
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: archive,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black54,
            icon: Icons.archive_rounded,
          ),
        ],
      ),

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: edit,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black54,
            icon: Icons.edit_rounded,
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 44, //minimum height
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                child: Align(
                  alignment: widget.text.contains(r'$center')
                      ? Alignment.center
                      : Alignment.centerLeft,
                  child: Text(
                    "${parseText(widget.text)}",
                    textAlign: widget.text.contains(r'$center')
                        ? TextAlign.center
                        : TextAlign.start,
                    style: GoogleFonts.zenMaruGothic(
                      color: Colors.black45,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  String parseText(String text) {
    text = text.replaceAll(r'$center', '');
    text = text.replaceAll(
        "\$line", '-------------------------------------------');

    return text;
  }
}
