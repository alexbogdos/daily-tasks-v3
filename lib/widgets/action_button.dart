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

  const ActionButton(
      {required this.context,
        required this.title,
        required this.widthP,
        required this.heightP,
        required this.color,
        required this.function,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context = this.context;
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: MediaQuery.of(context).size.width * widthP,
        height: MediaQuery.of(context).size.height * heightP,
        decoration: BoxDecoration(
          color: color,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8.0,
              offset: Offset(-4.0, 4.0),
            ),
          ],
          shape: BoxShape.rectangle,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: function,
            highlightColor: Colors.white12,
            splashColor: Colors.white12,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Center(
                child: AutoSizeText(
                  "${title}",
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
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
