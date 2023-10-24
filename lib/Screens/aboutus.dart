import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';


class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> with SingleTickerProviderStateMixin {

  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize = Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize).animate(CurvedAnimation(parent: animationController!, curve: Curves.linear));

    return Scaffold(
      body: Stack(
        //    overflow: Overflow.visible,
        children: [
          // Lets add some decorations
          Positioned(
              top: 100,
              right: -50,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: purple
                ),
              )
          ),
          Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: PinkColors
                ),
              )
          ),
          Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Center(
                      child: Icon(Icons.arrow_back_ios,color: blackColor,size: 20,),
                    )
                ),
              )
          ),
          Align(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // (choosenLanguage != '') ?
                    // Text(
                    //   languages[choosenLanguage]['About Us'],
                    //   style: GoogleFonts.roboto(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 24,
                    //     color: PinkColors
                    //   ),
                    // ):Container(),
                    // SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (choosenLanguage != '') ?Text(languages[choosenLanguage]['OURVISION'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                            SizedBox(height: 10,),
                            (choosenLanguage != '') ?Text(languages[choosenLanguage]['OURVISIONC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                            SizedBox(height: 10,),
                            (choosenLanguage != '') ?Text(languages[choosenLanguage]['OURMISSION'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                            SizedBox(height: 10,),
                            (choosenLanguage != '') ?Text(languages[choosenLanguage]['OURMISSIONC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                            SizedBox(height: 10,),
                            (choosenLanguage != '') ?Text(languages[choosenLanguage]['OFFICE'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                            SizedBox(height: 10,),
                            (choosenLanguage != '') ?Text(languages[choosenLanguage]['OFFICEC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                (choosenLanguage != '') ?Text(languages[choosenLanguage]['WEBSITE'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                                (choosenLanguage != '') ?Text(languages[choosenLanguage]['WEBSITEL'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                (choosenLanguage != '') ?Text(languages[choosenLanguage]['EMAIL'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                                (choosenLanguage != '') ?Text(languages[choosenLanguage]['EMAILL'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                              ],
                            ),
                         ]
                        )
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}