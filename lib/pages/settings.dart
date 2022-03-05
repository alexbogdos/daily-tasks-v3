import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageSettings extends StatefulWidget {
  const PageSettings({Key? key}) : super(key: key);

  @override
  _PageSettingsState createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
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
                            onPressed: () async {
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
}
