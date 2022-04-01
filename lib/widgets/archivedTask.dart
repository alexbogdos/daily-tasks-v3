// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:daily_tasks_v3/widgets/task_slidable.dart';
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
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Column(
                children: [
                  parseText(text),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "$date",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF343434).withOpacity(0.8),
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
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
