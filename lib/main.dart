import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/pages/coding.dart';
import 'package:daily_tasks_v3/pages/economics.dart';
import 'package:daily_tasks_v3/pages/greek.dart';
import 'package:daily_tasks_v3/pages/loading_page.dart';
import 'package:daily_tasks_v3/pages/mathematics.dart';
import 'package:daily_tasks_v3/pages/settings.dart';
import 'package:daily_tasks_v3/widgets/menu_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/personal.dart';

void main() {
  runApp(const GetMaterialApp(
    home: LoadingScreen(),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE9C46A),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffE9C46A), Color(0xffF4A261)],
                stops: [0.0, 1.0],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height * 0.02)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.74,
                    height: MediaQuery.of(context).size.height * 0.12,
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                      child: AutoSizeText(
                        'Your\ntopics:',
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          shadows: [
                            const Shadow(
                              blurRadius: 8.0,
                              color: Colors.black12,
                              offset: Offset(-4.0, 4.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                  MenuButton(
                    context: context,
                    title: "Personal",
                    fontSize: 24.0,
                    icon: Icons.person_rounded,
                    widthP: 0.74,
                    color: PagePersonal.backgroundColors[0],
                    function: () {
                      Get.to(() => PagePersonal,
                          transition: Transition.downToUp,
                          duration: const Duration(milliseconds: 200));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.042,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.74,
                    height: 100,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MenuButton(
                          context: context,
                          title: "Mathematics",
                          fontSize: 20.0,
                          icon: Icons.functions_rounded,
                          widthP: 0.32,
                          color: PageMathematics.backgroundColors[0],
                          function: () {
                            Get.to(() => PageMathematics,
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 200));
                          },
                        ),
                        MenuButton(
                          context: context,
                          title: "Economics",
                          fontSize: 20.0,
                          icon: Icons.attach_money_rounded,
                          widthP: 0.32,
                          color: pageEconomics.backgroundColors[0],
                          function: () {
                            Get.to(() => pageEconomics,
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 200));
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.031,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.74,
                    height: MediaQuery.of(context).size.height * 0.112,
                    decoration: const BoxDecoration(),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MenuButton(
                          context: context,
                          title: "Greek",
                          fontSize: 20.0,
                          icon: Icons.language_rounded,
                          widthP: 0.32,
                          color: pageGreek.backgroundColors[0],
                          function: () {
                            Get.to(() => pageGreek,
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 200));
                          },
                        ),
                        MenuButton(
                          context: context,
                          title: "Coding",
                          fontSize: 20.0,
                          icon: Icons.computer_rounded,
                          widthP: 0.32,
                          color: pageCoding.backgroundColors[0],
                          function: () {
                            Get.to(() => pageCoding,
                                transition: Transition.downToUp,
                                duration: const Duration(milliseconds: 200));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.031,
                  ),
                  MenuButton(
                    context: context,
                    title: "Settings",
                    fontSize: 24.0,
                    icon: Icons.settings_rounded,
                    widthP: 0.74,
                    color: const Color(0xffF4A261),
                    function: () {
                      Get.to(() => const PageSettings(),
                          transition: Transition.upToDown,
                          duration: const Duration(milliseconds: 200));
                    },
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
