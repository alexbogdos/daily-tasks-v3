// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Container MenuButton(context, title, fontSize, icon, widthP, color, function) {
//   return
// }

class ActionButton extends StatelessWidget {
  final BuildContext context;
  final String title;
  final double widthP;
  final double heightP;
  final Color color;
  final function;
  final function2;

  const ActionButton(
      {required this.context,
      required this.title,
      required this.widthP,
      required this.heightP,
      required this.color,
      required this.function,
      required this.function2,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context = this.context;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF343434).withOpacity(0.1),
            blurRadius: 6.0,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: MediaQuery.of(context).size.width * widthP,
          height: MediaQuery.of(context).size.height * heightP,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: function,
              onLongPress: function2,
              highlightColor: const Color(0xFF343434).withOpacity(0.2),
              splashColor: const Color(0xFF343434).withOpacity(0.2),
              hoverColor: const Color(0xFF343434).withOpacity(0.2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Center(
                  child: AutoSizeText(
                    "${title}",
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF343434),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
