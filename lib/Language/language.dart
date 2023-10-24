import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:pinkPower/Screens/Auth/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Languages extends StatefulWidget {
  final bool alreadyShown;
  Languages({Key? key, required this.alreadyShown}) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  @override
  void initState() {
    choosenLanguage = 'en';
    languageDirection = 'ltr';
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      !widget.alreadyShown
          ? showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Welcome to Pink Shakit!'),
                content: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                              'Pink Shakti collects background sms permission to send your current location to your trusted contacts in an emergency shake situation.\nPink Shakti collects a background location to send the current location to your trusted contacts in an emergency shake situation.'),
                        ],
                      ),
                    )),
                actions: [
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: Text(
                      'DENY',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('alreadyShown', true);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ACCEPT',
                      style: TextStyle(fontSize: 18, color: Colors.indigo),
                    ),
                  ),
                ],
              ),
            )
          : "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
        color: PinkColors.withOpacity(0.99),
        child: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.fromLTRB(media.width * 0.05, media.width * 0.05,
                media.width * 0.05, media.width * 0.05),
            height: media.height * 1,
            width: media.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height:
                      media.width * 0.11 + MediaQuery.of(context).padding.top,
                  width: media.width * 1,
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Stack(
                    children: [
                      Container(
                        height: 60,
                        width: media.width * 1,
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          (choosenLanguage.isEmpty)
                              ? 'Select Language'
                              : languages[choosenLanguage]
                                  ['text_choose_language'],
                          style: GoogleFonts.roboto(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: languages
                              .map((i, value) => MapEntry(
                                  i,
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        choosenLanguage = i;
                                        if (choosenLanguage == 'ar' ||
                                            choosenLanguage == 'ur' ||
                                            choosenLanguage == 'iw') {
                                          languageDirection = 'rtl';
                                        } else {
                                          languageDirection = 'ltr';
                                        }
                                      });
                                      final prefs = await SharedPreferences.getInstance();
                                      await prefs.setString('choosenlan', i);
                                      await prefs.setString('choosendirection', 'rtl');
                                    },
                                    child: InkWell(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding:
                                            EdgeInsets.all(media.width * 0.025),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 10,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                height: 80,
                                                padding: EdgeInsets.only(
                                                    top: 15, left: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                      width: 8,
                                                      color:
                                                          choosenLanguage == i
                                                              ? Colors.purple
                                                              : Colors.white,
                                                    )),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        languagesCode
                                                            .firstWhere((e) =>
                                                                e['code'] ==
                                                                i)['name']
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    blackColor),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Image.asset(
                                                      'assets/images/english-language.png',
                                                      width: 50,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )))
                              .values
                              .toList(),
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                //button
                (choosenLanguage != '')
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 12,
                            backgroundColor: purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            languages[choosenLanguage]['text_next'],
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ));
  }
}
