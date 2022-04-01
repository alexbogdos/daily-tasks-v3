// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Container MenuButton(context, title, fontSize, icon, widthP, color, function) {
//   return
// }

class ActionButton extends StatefulWidget {
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
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  final Color titleColor = const Color(0xFF343434);
  final Color highlightRectColor = const Color(0xFF736ff1);
  final Color highlightTitleColor = const Color(0xFFfdfdfd);

  late bool highlighted = false;

  @override
  Widget build(BuildContext context) {
    context = widget.context;
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
          width: MediaQuery.of(context).size.width * widget.widthP,
          height: MediaQuery.of(context).size.height * widget.heightP,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.rectangle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.function,
              onLongPress: widget.function2,
              onHover: (state) {
                setState(() {
                  highlighted = state;
                });
              },
              onHighlightChanged: (state) {
                setState(() {
                  highlighted = state;
                });
              },
              highlightColor: highlightRectColor.withOpacity(0.5),
              splashColor: highlightRectColor,
              hoverColor: highlightRectColor..withOpacity(0.5),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Center(
                  child: AutoSizeText(
                    "${widget.title}",
                    style: GoogleFonts.poppins(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      color: !highlighted ? titleColor : highlightTitleColor,
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
