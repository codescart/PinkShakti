import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';

class SecondNumber extends StatefulWidget {
  @override
  _SecondNumberState createState() => _SecondNumberState();
}

class _SecondNumberState extends State<SecondNumber> with SingleTickerProviderStateMixin {

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
  TextEditingController name=TextEditingController();
  TextEditingController phone=TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom; // we are using this to determine Keyboard is opened or not
    double defaultLoginSize = size.height - (size.height * 0.2);
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
                    color: PinkColors
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
          Container(
            margin: EdgeInsets.only(top: 40,left: 10),
            child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon:  Icon(Icons.arrow_back_ios)),
          ),
          Align(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (choosenLanguage != '') ?
                    Text(
                      languages[choosenLanguage]['Add Second Number'],
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                      ),
                    ):Container(),
                    SizedBox(height: 40,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          (choosenLanguage != '') ?  InputContainer(
                              child: TextField(
                                // maxLines: 5,
                                controller: name,
                                cursorColor: PinkColors,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.person, color: PinkColors
                                  ),
                                  hintText: languages[choosenLanguage]['Name'],hintStyle: GoogleFonts.roboto(),
                                  border: InputBorder.none,
                                ),
                              )
                          ):Container(),
                          const SizedBox(height: 5,),
                          (choosenLanguage != '') ?  InputContainer(
                              child: TextField(
                                // maxLines: 5,
                                controller: phone,
                                cursorColor: PinkColors,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.phone_android_sharp, color: PinkColors
                                  ),
                                  hintText: languages[choosenLanguage]['Mobile Number'],hintStyle: GoogleFonts.roboto(),
                                  border: InputBorder.none,
                                ),
                              )
                          ):Container(),
                          const SizedBox(height: 10,),
                          (choosenLanguage != '') ? Container(
                            width: 290,
                            height: 50,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 12,
                                  backgroundColor: PinkColors,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>BottomNavigation()));
                                }, child: Text(languages[choosenLanguage]['Next'])),
                          ):Container(),
                        ],
                      ),
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