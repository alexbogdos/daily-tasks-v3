import 'dart:io' show Directory, Platform;
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daily_tasks_v3/pages/coding.dart';
import 'package:daily_tasks_v3/pages/economics.dart';
import 'package:daily_tasks_v3/pages/greek.dart';
import 'package:daily_tasks_v3/pages/mathematics.dart';
import 'package:daily_tasks_v3/pages/personal.dart';
import 'package:daily_tasks_v3/widgets/action_button.dart';
import 'package:daily_tasks_v3/widgets/date_indicator.dart';
import 'package:daily_tasks_v3/widgets/settings_bottom_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? _directoryPath = "";
String? _tempDirectoryPath = "";

String _lastBackupDate = "";

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

  Future<void> _selectTempFolder() async {
    await FilePicker.platform.getDirectoryPath().then((value) {
      if (!(value == null && _directoryPath != null)) {
        setState(() => _tempDirectoryPath = value);
      }
    });
  }

  late bool retrieved = false;

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
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
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
                                  color:
                                      const Color(0xFF343434).withOpacity(0.9),
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
                                      color: const Color(0xFF343434)
                                          .withOpacity(0.8),
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
                                _selectFolder().then((value) =>
                                    savePath(path: "$_directoryPath"));
                              },
                              function2: () {},
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ActionButton(
                                context: context,
                                title: "Create Backup",
                                widthP: 0.6,
                                heightP: 0.08,
                                color: const Color(0xFFFFFFFF).withOpacity(0.9),
                                function: () async {
                                  if (_directoryPath == "") {
                                    _selectFolder().then((value) =>
                                        openAndSave("$_directoryPath", true));
                                  } else {
                                    saveFiles("$_directoryPath");
                                  }
                                },
                                function2: () async {
                                  _selectTempFolder().then((value) =>
                                      openAndSave(
                                          "$_tempDirectoryPath", false));
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            ActionButton(
                              context: context,
                              title: "Retrieve Backup",
                              widthP: 0.6,
                              heightP: 0.08,
                              color: const Color(0xFFFFFFFF).withOpacity(0.9),
                              function: () async {
                                setState(() {
                                  retrieved = true;
                                });
                                if (_directoryPath == "") {
                                  _selectFolder().then((value) =>
                                      openAndLoad("$_directoryPath", true));
                                } else {
                                  loadFiles("$_directoryPath");
                                }
                              },
                              function2: () async {
                                retrieved = true;
                                _selectTempFolder().then((value) =>
                                    openAndLoad("$_tempDirectoryPath", false));
                              },
                            ),
                          ],
                        ),
                        Align(
                          alignment: const Alignment(0.56, 0.01),
                          child: DateIndicator(date: _lastBackupDate),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: SettingsBottomButton(shouldRebuild: retrieved),
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

  Future<void> saveFiles(String path) async {
    if (await Directory(path).exists()) {
      if (PagePersonal.opened == false) {
        await retrieveLists_personal();
      }
      await saveFile_personal(path);

      if (PageMathematics.opened == false) {
        await retrieveLists_mathematics();
      }
      await saveFile_mathematics(path);

      if (PageEconomics.opened == false) {
        await retrieveLists_economics();
      }
      await saveFile_economics(path);

      if (PageGreek.opened == false) {
        await retrieveLists_greek();
      }
      await saveFile_greek(path);

      if (PageCoding.opened == false) {
        await retrieveLists_coding();
      }
      await saveFile_coding(path);

      String month = "${DateTime.now().day}/${DateTime.now().month}";
      String minutes = "${DateTime.now().hour}:${DateTime.now().minute}";

      if (DateTime.now().minute < 10) {
        minutes = "${DateTime.now().hour}:0${DateTime.now().minute}";
      }

      setState(() {
        _lastBackupDate = "$month $minutes";
      });
      await saveLastBackupDate();

      showToastMessage("Backup Created");
    } else {
      showToastMessage("PATH DOES NOT EXIST");
      if (kDebugMode) {
        print("PATH DOES NOT EXIST");
      }
    }
  }

  Future<void> loadFiles(String path) async {
    if (await Directory(path).exists()) {
      await readFile_personal(path);
      await readFile_mathematics(path);
      await readFile_greek(path);
      await readFile_economics(path);
      await readFile_coding(path);
      showToastMessage("Backup Retrieved");
    } else {
      showToastMessage("PATH DOES NOT EXIST");
      if (kDebugMode) {
        print("PATH DOES NOT EXIST");
      }
    }
  }

  void openAndSave(String path, bool save) async {
    if (path == "") {
      return;
    }

    await saveFiles(path);
    if (save == true) {
      await savePath(path: path);
    }
    path = parsePath(path);
    showToastMessage("Using:\n$path");
  }

  void openAndLoad(String path, bool save) async {
    if (path == "") {
      return;
    }
    await loadFiles(path);
    if (save == true) {
      await savePath(path: path);
    }
    path = parsePath(path);
    showToastMessage("Using:\n$path");
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

Future<void> savePath({required String path}) async {
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

Future<void> saveLastBackupDate() async {
  if (_lastBackupDate != "") {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("lastDate", _lastBackupDate);
  }
}

Future<void> loadLastBackupDate() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("lastDate")) {
    _lastBackupDate = prefs.getString("lastDate")!;

    if (!(await Directory(_directoryPath!).exists())) {
      _lastBackupDate = "";
    }
  }
}
