import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';


class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}
class _PrivacyPolicyState extends State<PrivacyPolicy> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(
        title: (choosenLanguage != '') ?
        Text(
          languages[choosenLanguage]['PRIVACYPOLICY'],
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            color: Colors.white,)
        ):Container(),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: PinkColors,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,size: 20,),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['PRIVACYPOLICYC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['WHATDOES'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['WHATDOESC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['WHATINFO'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['WHATINFOC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['REGISTRATION'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['REGISTRATIONC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['INFORMATION'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['INFORMATIONC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['SUBMISSION'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['SUBMISSIONC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['OUTSIDE'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['OUTSIDEC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['AUTOMATICALLY'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['AUTOMATICALLYC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['HOWWE'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['HOWWEC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['REVISIONS'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['REVISIONSC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['CHILDRENP'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['CHILDRENPC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['ANALYTICS'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['ANALYTICSC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['THIRDPARTY'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['THIRDPARTYC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['PUSH'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['PUSHC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['STORAGE'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['STORAGEC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['YOURRIGHTS'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['YOURRIGHTSC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['CONTACTINGUS'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['CONTACTINGUSC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
                    ]
                )
            ),
          ],
        ),
      ),
    );
  }
}
