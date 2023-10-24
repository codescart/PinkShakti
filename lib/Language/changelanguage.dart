import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  State<ChangeLanguage> createState() => _ChangeLanguageState();
}
class _ChangeLanguageState extends State<ChangeLanguage> {
  @override
  void initState() {
    choosenLanguage = 'en';
    languageDirection = 'ltr';
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
        color: PinkColors.withOpacity(0.9),
        child: Directionality(
          textDirection:
          (languageDirection == 'rtl') ? TextDirection.rtl : TextDirection.ltr,
          child: Container(
            padding: EdgeInsets.fromLTRB(media.width * 0.05, media.width * 0.05,
                media.width * 0.05, media.width * 0.05),
            height: media.height * 1,
            width: media.width * 1, child: Column(
            children: [
              Container(
                height: media.width * 0.11 + MediaQuery.of(context).padding.top,
                width: media.width * 1,
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Stack(
                  children: [
                    Container(
                      height:60,
                      width: media.width * 1,
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        (choosenLanguage.isEmpty)
                            ? 'Select Language'
                            : languages[choosenLanguage]['text_choose_language'],
                        style: GoogleFonts.roboto(
                            color: whiteColor,
                            fontSize:20,
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
                  child: Column(
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
                            // final prefs= await SharedPreferences.getInstance();
                            // await prefs.setString('choosenlan', i);
                            // await prefs.setString('choosendirection', 'rtl');
                          },
                          child:  Container(

                            padding: EdgeInsets.all(media.width * 0.025),
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 10,
                                  child: Container(
                                    width:MediaQuery.of(context).size.width*0.8,
                                    height:80,
                                    padding: EdgeInsets.only(top: 15, left: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 8,
                                          color: choosenLanguage==i?Colors.purple: Colors.white,
                                        )
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Center(
                                          child: Text(
                                            languagesCode
                                                .firstWhere(
                                                    (e) => e['code'] == i)['name']
                                                .toString(),
                                            style: GoogleFonts.roboto(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: blackColor),
                                          ),
                                        ),
                                        SizedBox(width: 20,),
                                        Image.asset('assets/images/english-language.png',width: 50,)
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )))
                        .values
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //button
              (choosenLanguage != '')?  Container(
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
                  onPressed: () async{
                    final prefs= await SharedPreferences.getInstance();
                    await prefs.setString('choosenlan', choosenLanguage);
                    await prefs.setString('choosendirection', 'rtl');
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNavigation()));
                  },
                  child: Text(
                    languages[choosenLanguage]['text_next'],
                    style: TextStyle(fontSize: 25)
                    ,) ,),
              ): Container(),
            ],
          ),
          ),
        ));
  }
}
