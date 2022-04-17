import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    required this.tasksListLength,
    required this.archivedListLength,
    Key? key,
  }) : super(key: key);

  final int tasksListLength;
  final int archivedListLength;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: const Color(0xFF343434),
      labelStyle:
          GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600),
      indicatorColor: const Color(0xFF343434).withOpacity(0.8),
      tabs: [
        Tab(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Tasks"),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 40,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '$tasksListLength',
                    style: TextStyle(
                      color: const Color(0xFF343434).withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF343434).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ],
        )),
        Tab(
            child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("History"),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 40,
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    '$archivedListLength',
                    style: TextStyle(
                      color: const Color(0xFF343434).withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF343434).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ],
        )),
      ],
    );
  }
}
