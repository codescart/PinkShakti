import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:url_launcher/url_launcher.dart';

class Gov_Policies extends StatefulWidget {
  @override
  _Gov_PoliciesState createState() => _Gov_PoliciesState();
}

class _Gov_PoliciesState extends State<Gov_Policies> with SingleTickerProviderStateMixin {

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
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height*0.31,
            width: MediaQuery.of(context).size.width,
            child:   Stack(
              children: [
                Positioned(
                    top: 100,
                    right: -50,
                    child: Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
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
                // (choosenLanguage != '') ?
                // Container(
                //   margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
                //   child: Center(
                //     child: Text(
                //       languages[choosenLanguage]['Govt.Policies'],
                //       style: GoogleFonts.roboto(
                //           fontWeight: FontWeight.bold,
                //           fontSize: 24,
                //           color: PinkColors
                //       ),
                //     ),
                //   ),
                // ):Container(),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.68,
            child: ListView(
              children: [
                Padding(padding: const EdgeInsets.all(8.0)   ,
                  child: Container(
                      child: (choosenLanguage != '') ?Text(languages[choosenLanguage]['GOVTPOLICY'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify):Text("")
                  ),
                ),
                SizedBox(height: 40,),
                (choosenLanguage != '') ?   Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 12,
                    child: InkWell(
                      onTap: (){
                        _launchURL();
                        },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: PinkColors
                        ),
                        child: Center(
                            child: Text(languages[choosenLanguage]['KnowMore'],style: TextStyle(fontSize: 20,color: Colors.white),)),
                      ),
                    )
                ):Container(),
              ],
            ),
          )
        ],
      )
    );
  }
}

_launchURL() async {
  const url = 'https://pinkshakti.in/policies.html';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }
}