import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/pages/coding.dart';
import 'package:daily_tasks_v3/pages/economics.dart';
import 'package:daily_tasks_v3/pages/greek.dart';
import 'package:daily_tasks_v3/pages/mathematics.dart';
import 'package:daily_tasks_v3/pages/personal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:file_picker/file_picker.dart';

class PageSettings extends StatefulWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  String? _directoryPath;

  Future<void> _selectFolder() async {
    await FilePicker.platform.getDirectoryPath().then((value) {
      setState(() => _directoryPath = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8c774),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xffe8c774), Color(0xfff1a76c)],
                stops: [0.0, 1.0],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height * 0.02)),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.74,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                            child: AutoSizeText(
                              'Settings:',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
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
                        ElevatedButton(
                          onPressed: () async {
                            _selectFolder().then((value) => saveFiles("$_directoryPath"));
                          },
                          child: Text("Save BackUps | Select Root Folder"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            _selectFolder().then((value) => loadFiles("$_directoryPath"));
                          },
                          child: Text("Retrieve BackUps | Select Root Folder"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: AutoSizeText(
                              'Apply & Go Back',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(''),
                            style: TextButton.styleFrom(
                              primary: Colors.white12,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  String getRandom(){
    const ch = 'AaBbCcDdEeFf';
    const num = '0123456789';
    Random r = Random();
    String str1 =  String.fromCharCodes(Iterable.generate(
        2, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
    String str2 =  String.fromCharCodes(Iterable.generate(
        2, (_) => num.codeUnitAt(r.nextInt(num.length))));
    return "$str1$str2";
  }
  
  void saveFiles(String path) {
    saveFile_personal(path);
    saveFile_mathematics(path);
    saveFile_greek(path);
    saveFile_economics(path);
    saveFile_coding(path);
  }

  void loadFiles(String path) {
    readFile_personal(path);
    readFile_mathematics(path);
    readFile_greek(path);
    readFile_economics(path);
    readFile_coding(path);
  }

  void showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        //message to show toast
        toastLength: Toast.LENGTH_SHORT,
        //duration for message to show
        gravity: ToastGravity.TOP,
        //where you want to show, top, bottom
        backgroundColor: Colors.black54,
        //background Color for message
        textColor: Colors.white,
        //message text color
        fontSize: 16.0 //message font size
        );
  }
}
