// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuButton extends StatefulWidget {
  final BuildContext context;
  final String title;
  final double fontSize;
  final IconData icon;
  final double widthP;
  final Color color;
  final function;

  const MenuButton(
      {required this.context,
      required this.title,
      required this.fontSize,
      required this.icon,
      required this.widthP,
      required this.color,
      required this.function,
      Key? key})
      : super(key: key);

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  final Color titleColor = const Color(0xFF343434);
  final Color highlightRectColor = const Color(0xFF736ff1);
  final Color highlightTitleColor = const Color(0xFFfdfdfd);

  late bool highlighted = false;

  @override
  Widget build(BuildContext context) {
    context = widget.context;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 175),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: !highlighted
                ? titleColor.withOpacity(0.1)
                : titleColor.withOpacity(0.25),
            blurRadius: 6.0,
            offset: !highlighted ? const Offset(6, 6) : const Offset(10, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: MediaQuery.of(context).size.width * widget.widthP,
          height: MediaQuery.of(context).size.height * 0.112,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.rectangle,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 125), () {
                  widget.function();
                });
              },
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
              hoverColor: highlightRectColor.withOpacity(0.6),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AutoSizeText(
                      "${widget.title}",
                      style: GoogleFonts.poppins(
                        fontSize: widget.fontSize * 1.0,
                        fontWeight: FontWeight.w500,
                        color: !highlighted ? titleColor : highlightTitleColor,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Icon(
                        widget.icon,
                        color: !highlighted ? titleColor : highlightTitleColor,
                        size: 42,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
