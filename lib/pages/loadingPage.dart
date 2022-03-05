import 'dart:async';
import 'package:daily_tasks_v3/main.dart';
import 'package:daily_tasks_v3/pages/coding.dart';
import 'package:daily_tasks_v3/pages/economics.dart';
import 'package:daily_tasks_v3/pages/greek.dart';
import 'package:daily_tasks_v3/pages/personal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'mathematics.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double value = 0;

  void initState() {
    super.initState();
    indicateProgress();
    retrieveData().then((value) => _goToHomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9C46A),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xffE9C46A), Color(0xffF4A261)],
              stops: [0.0, 1.0],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Loading..',
                style: GoogleFonts.poppins(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 14.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.black26,
                  color: Colors.white70,
                  minHeight: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> retrieveData() async {
    await retrieveLists_personal();
    await retrieveLists_mathematics();
    await retrieveLists_economics();
    await retrieveLists_greek();
    await retrieveLists_coding();

    print("Data Retrieved");
  }

  void indicateProgress() {
    new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (timer.isActive) {
        print('DISPOSE');
        timer.cancel();
        return;
      } else {
        setState(() {
          if (value >= 0.9) {
            timer.cancel();
          } else {
            value = value + 0.1;
          }
        });
      }
    });
  }

  _goToHomePage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MainPage()));
  }
}
