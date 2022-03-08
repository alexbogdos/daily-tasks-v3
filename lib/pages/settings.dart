import 'dart:io' show Platform;
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
import 'package:permission_handler/permission_handler.dart';

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

    askPermissions();

    return Scaffold(
      backgroundColor: const Color(0xffe8c774),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
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
                                const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                            child: AutoSizeText(
                              'Settings:',
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
                        ElevatedButton(
                          onPressed: () async {
                            _selectFolder().then((value) => saveFiles("$_directoryPath"));
                          },
                          child: const Text("Save BackUps | Select Root Folder"),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            _selectFolder().then((value) => loadFiles("$_directoryPath"));
                          },
                          child: const Text("Retrieve BackUps | Select Root Folder"),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
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
                            child: const Text(''),
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
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 16.0
        );
  }

  void askPermissions() async {
    if (!Platform.isAndroid) {
      return;
    }

    if (!(await Permission.storage.isGranted)){
      await Permission.storage.request();
    }
    if (!(await Permission.manageExternalStorage.isGranted)){
      await Permission.manageExternalStorage.request();
    }
  }
}
