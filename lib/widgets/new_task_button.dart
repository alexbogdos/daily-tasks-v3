import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/widgets/edittask_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
