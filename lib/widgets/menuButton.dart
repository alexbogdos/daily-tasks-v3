import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Container MenuButton(context, title, fontSize, icon, widthP, color, function) {
//   return
// }

class MenuButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    context = this.context;
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        width: MediaQuery.of(context).size.width * this.widthP,
        height: MediaQuery.of(context).size.height * 0.112,
        decoration: BoxDecoration(
          color: this.color,
          boxShadow: [
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
            onTap: this.function,
            highlightColor: Colors.white12,
            splashColor: Colors.white12,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AutoSizeText(
                    "${this.title}",
                    style: GoogleFonts.poppins(
                      fontSize: this.fontSize * 1.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Icon(
                      this.icon,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
