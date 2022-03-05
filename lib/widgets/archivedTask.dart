import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArchivedTask extends StatelessWidget {
  final BuildContext context;
  final int index;
  final String text;
  final List<Color> colors;
  final String date;

  const ArchivedTask(
      {required this.context,
      required this.index,
      required this.text,
      required this.colors,
      required this.date,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: Column(
                children: [
                  Align(
                    alignment: this.text.contains(r'$center')
                        ? Alignment.center
                        : Alignment.centerLeft,
                    child: Text(
                      "${parseText(this.text)}",
                      textAlign: this.text.contains(r'$center')
                          ? TextAlign.center
                          : TextAlign.start,
                      style: GoogleFonts.zenMaruGothic(
                        color: Colors.black45,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$date",
                      style: GoogleFonts.poppins(
                        color: Colors.black45,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  String parseText(String text) {
    text = text.replaceAll(r'$center', '');
    text = text.replaceAll(
        "\$line", '-------------------------------------------');

    return text;
  }
}
