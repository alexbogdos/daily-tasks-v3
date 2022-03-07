// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTaskDialog {
  final context;
  final List<Color> colors;
  final int index;
  final List<String> tasksList;
  final notifyParent;
  final bool isNew;

  late String text;

  EditTaskDialog({
    required this.context,
    required this.isNew,
    required this.colors,
    required this.index,
    required this.tasksList,
    required this.notifyParent,
  });

  Future<void> show() async {
    text = tasksList[index];
    String editedText = text;

    return await showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 300,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
                stops: const [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding:
                const EdgeInsets.symmetric(vertical: 6.0, horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Edit Task',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                Form(
                  child: TextFormField(
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
                        fillColor: colors[0].withOpacity(0.2),
                        filled: true),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (isNew)
                      ElevatedButton(
                        onPressed: () {
                          tasksList.removeAt(index);
                          Navigator.of(context).pop();
                          notifyParent();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          child: Text(
                            "Cancel",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      )
                    else
                      ElevatedButton(
                        onPressed: () {
                          _confirmationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          child: Text(
                            "Delete",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        tasksList[index] = editedText;
                        Navigator.of(context).pop();
                        notifyParent();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        child: Text(
                          "Save",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  OutlineInputBorder unfocusedBorder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for Text Field
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: colors[0],
          width: 3,
        ));
  }

  OutlineInputBorder focusedBorder() {
    //return type is OutlineInputBorder
    return OutlineInputBorder(
        //Outline border type for Text Field
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: colors[1],
          width: 3,
        ));
  }

  void _confirmationDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            title: Text(
              'Confirmation',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            content: Text(
              'This action is irreversible. Continue?',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  tasksList.removeAt(index);
                  Navigator.of(context).pop();
                  notifyParent();
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(primary: Colors.redAccent),
                child: Text(
                  'Yes',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(primary: Colors.blueAccent),
                child: Text(
                  'No',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueAccent,
                  ),
                ),
              )
            ],
          );
        });
  }
}
