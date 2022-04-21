import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateIndicator extends StatelessWidget {
  const DateIndicator({
    Key? key,
    required this.date,
  }) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    if (date == "") {
      return const SizedBox.shrink();
    } else {
      return Container(
        width: 76,
        height: 22,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: const Color(0xFF736ff1),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF343434).withOpacity(0.1),
              blurRadius: 6.0,
              offset: const Offset(6, 6),
            )
          ],
        ),
        child: Center(
          child: AutoSizeText(
            date,
            maxLines: 1,
            maxFontSize: 12,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }
}
