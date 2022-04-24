import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void confirmationDialog(BuildContext context,
    {required List<String> tasksList,
    required int index,
    required String text,
    required Function saveLists,
    required Function notifyParent}) {
  String subtext = text;

  int times = 0;
  int _index = 0;
  for (String char in subtext.characters) {
    if (char == " " && times < 3) {
      times += 1;
    } else if (times >= 3) {
      break;
    }
    _index += 1;
  }

  if (times >= 3 && _index - 1 <= subtext.lastIndexOf(" ")) {
    subtext = "${subtext.substring(0, _index - 1)}..";
  }

  showDialog(
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        title: Text(
          'Confirmation',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        content: Text(
          'This action is irreversible.\nDelete "$subtext" ?',
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              notifyParent(() {
                tasksList.removeAt(index);
                saveLists();
                Navigator.of(context).pop();
              });
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
    },
  );
}
