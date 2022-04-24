// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String editedText = "";

class EditTaskDialog {
  EditTaskDialog({
    required this.context,
    required this.isNew,
    required this.index,
    required this.tasksList,
    required this.notifyParent,
  });

  final context;
  final int index;
  final List<String> tasksList;
  final notifyParent;
  final bool isNew;

  late String text;

  Future<void> show() async {
    text = tasksList[index];
    editedText = text;

    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: const Color(0xFFf0f1f2),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            width: double.infinity, //MediaQuery.of(context).size.width * 0.96,
            height: 304,
            decoration: BoxDecoration(
              color: const Color(0xFF6d69f1).withOpacity(0.6),
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                dialogTitle(isNew: isNew),
                Form(
                  child: TextFormField(
                    autofocus: true,
                    validator: (value) {
                      return value!.isNotEmpty ? null : "Invalid Field";
                    },
                    initialValue: text == 'New task' ? '' : '$text',
                    onChanged: (value) {
                      editedText = value;
                    },
                    minLines: 1,
                    maxLines: 5,
                    style: GoogleFonts.zenMaruGothic(
                        fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        enabledBorder: unfocusedBorder(),
                        focusedBorder: focusedBorder(),
                        fillColor: const Color(0xFFf0f1f2).withOpacity(0.2),
                        filled: true),
                  ),
                ),
                DialogBottomButtons(
                  isNew: isNew,
                  tasksList: tasksList,
                  index: index,
                  notifyParent: notifyParent,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Text dialogTitle({required bool isNew}) {
    return Text(
      isNew ? "Create" : "Edit",
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  OutlineInputBorder unfocusedBorder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
        //Outline border type for Text Field
        borderRadius: BorderRadius.all(Radius.circular(15)),
        borderSide: BorderSide(
          color: Color.fromARGB(255, 141, 138, 219),
          width: 2.4,
        ));
  }

  OutlineInputBorder focusedBorder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
      //Outline border type for Text Field
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(
        color: Color(0xFFf0f1f2),
        width: 2.4,
      ),
    );
  }
}

// ignore: must_be_immutable
class DialogBottomButtons extends StatelessWidget {
  const DialogBottomButtons({
    required this.isNew,
    required this.tasksList,
    required this.index,
    required this.notifyParent,
    Key? key,
  }) : super(key: key);

  final bool isNew;
  final List<String> tasksList;
  final int index;
  final Function notifyParent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        TextButton(
          onPressed: () {
            if (isNew) {
              tasksList.removeAt(index);
              Navigator.of(context).pop();
              // notifyParent();
            } else {
              Navigator.of(context).pop();
            }
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFf0f1f2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            child: Text(
              "Cancel",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: const Color(0xFF343434),
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            tasksList[index] = editedText;
            Navigator.of(context).pop();
            // notifyParent();
          },
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFf0f1f2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            child: Text(
              "Save",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: const Color(0xFF343434),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
