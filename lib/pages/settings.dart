import 'dart:io' show Directory, Platform;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/pages/coding.dart';
import 'package:daily_tasks_v3/pages/economics.dart';
import 'package:daily_tasks_v3/pages/greek.dart';
import 'package:daily_tasks_v3/pages/mathematics.dart';
import 'package:daily_tasks_v3/pages/personal.dart';
import 'package:daily_tasks_v3/widgets/action_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? _directoryPath = "";

class PageSettings extends StatefulWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  Future<void> _selectFolder() async {
    await FilePicker.platform.getDirectoryPath().then((value) {
      if (!(value == null && _directoryPath != null)) {
        setState(() => _directoryPath = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    askPermissions();

    return Scaffold(
      backgroundColor: const Color(0xffFAF4FB),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFf0f1f2),
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
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10, 10, 0, 0),
                            child: AutoSizeText(
                              'Settings:',
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                color: const Color(0xFF343434),
                                fontWeight: FontWeight.w700,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2.0,
                                    color: const Color(0xFF343434)
                                        .withOpacity(0.1),
                                    offset: const Offset(5.0, 5.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        Center(
                          child: AutoSizeText(
                            "Selected Path:",
                            style: GoogleFonts.poppins(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF343434).withOpacity(0.9),
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 0),
                              child: AutoSizeText(
                                parsePath("$_directoryPath"),
                                style: GoogleFonts.poppins(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      const Color(0xFF343434).withOpacity(0.8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.08,
                        ),
                        ActionButton(
                          context: context,
                          title: "Select Backup Folder",
                          widthP: 0.6,
                          heightP: 0.08,
                          color: const Color(0xFFFFFFFF).withOpacity(0.9),
                          function: () {
                            _selectFolder()
                                .then((value) => savePath("$_directoryPath"));
                          },
                          function2: () {},
                        ),
                        const SizedBox(height: 20),
                        ActionButton(
                          context: context,
                          title: "Create Backup",
                          widthP: 0.6,
                          heightP: 0.08,
                          color: const Color(0xFFFFFFFF).withOpacity(0.9),
                          function: () async {
                            if (_directoryPath == "") {
                              _selectFolder().then((value) => openAndSave());
                            } else {
                              saveFiles("$_directoryPath");
                            }
                          },
                          function2: () {
                            _selectFolder().then((value) => openAndSave());
                          },
                        ),
                        const SizedBox(height: 20),
                        ActionButton(
                          context: context,
                          title: "Retrieve Backup",
                          widthP: 0.6,
                          heightP: 0.08,
                          color: const Color(0xFFFFFFFF).withOpacity(0.9),
                          function: () async {
                            if (_directoryPath == "") {
                              _selectFolder().then((value) => openAndLoad());
                            } else {
                              loadFiles("$_directoryPath");
                            }
                          },
                          function2: () {
                            _selectFolder().then((value) => openAndLoad());
                          },
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
                              backgroundColor: Colors.transparent,
                              primary: Colors.white,
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

  String parsePath(String pathText) {
    if (pathText == "") {
      return pathText;
    }
    if (Platform.isAndroid) {
      pathText = pathText.replaceFirst(r"/", "");
      int index1 = pathText.indexOf(r"/");
      pathText = pathText.substring(index1 + 1);
      int index2 = pathText.indexOf(r"/");
      if (pathText.substring(0, index2) != "emulated") {
        pathText = pathText.replaceRange(0, index2, "sd");
      }
      return "../$pathText";
    }
    return pathText;
  }

  void saveFiles(String path) async {
    if (await Directory(path).exists()) {
      saveFile_personal(path);
      saveFile_mathematics(path);
      saveFile_greek(path);
      saveFile_economics(path);
      saveFile_coding(path);
      showToastMessage("Backup Created");
    } else {
      showToastMessage("PATH DOES NOT EXIST");
      if (kDebugMode) {
        print("PATH DOES NOT EXIST");
      }
    }
  }

  void loadFiles(String path) async {
    if (await Directory(path).exists()) {
      readFile_personal(path);
      readFile_mathematics(path);
      readFile_greek(path);
      readFile_economics(path);
      readFile_coding(path);
      showToastMessage("Backup Retrieved");
    } else {
      showToastMessage("PATH DOES NOT EXIST");
      if (kDebugMode) {
        print("PATH DOES NOT EXIST");
      }
    }
  }

  void openAndSave() {
    saveFiles("$_directoryPath");
    savePath("$_directoryPath");
    showToastMessage("Backup Created");
  }

  void openAndLoad() {
    loadFiles("$_directoryPath");
    savePath("$_directoryPath");
    showToastMessage("Backup Retrieved");
  }

  void showToastMessage(String message) {
    if (!Platform.isAndroid) {
      return;
    }

    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void askPermissions() async {
    if (!Platform.isAndroid) {
      return;
    }

    if (!(await Permission.storage.isGranted)) {
      await Permission.storage.request();
    }
    if (!(await Permission.manageExternalStorage.isGranted)) {
      await Permission.manageExternalStorage.request();
    }
  }
}

void savePath(String path) async {
  if (path != "") {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("backupPath", path);
  }
}

Future<void> loadPath() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("backupPath")) {
    _directoryPath = prefs.getString("backupPath");

    if (!(await Directory(_directoryPath!).exists())) {
      _directoryPath = "";
    }
  }
}
