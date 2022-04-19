import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsBottomButton extends StatelessWidget {
  const SettingsBottomButton({
    required this.shouldRebuild,
    Key? key,
  }) : super(key: key);

  final bool shouldRebuild;

  @override
  Widget build(BuildContext context) {
    String text;
    if (shouldRebuild == true) {
      text = "Apply & Restart";
    } else {
      text = "Go Back";
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: const Color(0xFF6d69f0),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF343434).withOpacity(0.1),
            blurRadius: 6.0,
            offset: const Offset(6, 6),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: AutoSizeText(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              await Future.delayed(const Duration(milliseconds: 125), () {
                if (shouldRebuild == true) {
                  Navigator.of(context).popAndPushNamed('/');
                  toRebuild = true;
                } else {
                  Navigator.of(context).pop();
                }
              });
            },
            child: const Text(''),
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              primary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
