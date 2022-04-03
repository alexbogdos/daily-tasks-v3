// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_string_interpolations
import 'dart:io' show Platform;

import 'package:daily_tasks_v3/widgets/edittask_dialog.dart';
import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      print(
          "archive task:\n  index: ${widget.index}\n  string: '${widget.text}'");
    }

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
    if (kDebugMode) {
      print("edit task:\n  index: ${widget.index}\n  string: '${widget.text}'");
    }

    EditTaskDialog(
      context: context,
      isNew: false,
      index: widget.index,
      tasksList: widget.tasksList,
      notifyParent: () {
        setState(() {});
      },
    ).show().then((value) => widget.notifyParent(widget.saveLists));
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
        motion: const ScrollMotion(),
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
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 44, //minimum height
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF).withOpacity(0.42),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Padding(
                padding:
                    Platform.isWindows || Platform.isMacOS || Platform.isLinux
                        ? const EdgeInsets.fromLTRB(10.0, 4.0, 12.0, 4.0)
                        : const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 4.0),
                child: parseText(widget.text),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}

Widget parseText(String text) {
  // text = text.replaceAll(r'$center', '');
  text =
      text.replaceAll("\$line", '-------------------------------------------');

  if (!text.contains(r'$title')) {
    return Align(
      alignment:
          text.contains(r'$center') ? Alignment.center : Alignment.centerLeft,
      child: Text(
        "${text.replaceAll(r"$center", "").trim()}",
        textAlign:
            text.contains(r'$center') ? TextAlign.center : TextAlign.start,
        style: GoogleFonts.zenMaruGothic(
          color: const Color(0xFF343434).withOpacity(0.9),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  } else {
    int index = text.indexOf(r"$title");

    String text1 = text.substring(0, index).trim();
    String text2 = text
        .substring(index)
        .replaceFirst("\n", "")
        .replaceAll(r"$titleCenter", "")
        .replaceAll(r"$title", "")
        .replaceAll(r"$center", "");
    return Column(
      children: [
        Align(
          alignment: text.contains(r'$titleCenter')
              ? Alignment.center
              : Alignment.centerLeft,
          child: Text(
            "${text1.trim()}",
            textAlign: text.contains(r'$titleCenter')
                ? TextAlign.center
                : TextAlign.start,
            style: GoogleFonts.zenMaruGothic(
              color: const Color(0xFF343434).withOpacity(0.96),
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        if (text2 != "")
          Align(
            alignment: text.substring(index).contains(r'$center')
                ? Alignment.center
                : Alignment.centerLeft,
            child: Text(
              "${text2.replaceAll(r'$center', "").trim()}",
              textAlign: text.substring(index).contains(r'$center')
                  ? TextAlign.center
                  : TextAlign.start,
              style: GoogleFonts.zenMaruGothic(
                color: const Color(0xFF343434).withOpacity(0.9),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
