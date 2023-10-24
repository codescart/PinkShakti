import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:http/http.dart' as http;
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstNumber extends StatefulWidget {
  @override
  _FirstNumberState createState() => _FirstNumberState();
}

class _FirstNumberState extends State<FirstNumber> with SingleTickerProviderStateMixin {

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
  TextEditingController  number=TextEditingController();
  TextEditingController   email=TextEditingController();


  @override 
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double viewInset = MediaQuery.of(context).viewInsets.bottom; // we are using this to determine Keyboard is opened or not
    double defaultLoginSize = size.height - (size.height * 0.2);
    double defaultRegisterSize = size.height - (size.height * 0.1);

    containerSize = Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize).animate(CurvedAnimation(parent: animationController!, curve: Curves.linear));

    return Scaffold(
      body: Stack(
        children: [
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
                      languages[choosenLanguage]['Add Emergency Contact Number'],
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                      ),
                    ):Container(),
                    SizedBox(height: 40,),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          (choosenLanguage != '') ?  InputContainer(
                              child: TextField(
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
                               controller: number,
                                keyboardType: TextInputType.number,
                                maxLength: 10,
                                cursorColor: PinkColors,
                                decoration: InputDecoration(
                                  counterText: "",
                                  icon: const Icon(Icons.phone_android_sharp, color: PinkColors
                                  ),
                                  hintText: languages[choosenLanguage]['Mobile Number'],hintStyle: GoogleFonts.roboto(),
                                  border: InputBorder.none,
                                ),
                              )
                          ):Container(),
                          const SizedBox(height: 10,),
                          (choosenLanguage != '') ?  InputContainer(
                              child: TextField(
                                controller: email,
                                cursorColor: PinkColors,
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.mail, color: PinkColors
                                  ),
                                  hintText: languages[choosenLanguage]['Email'],hintStyle: GoogleFonts.roboto(),
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
                                onPressed: ()async {
                                 Contact(name.text,number.text,email.text);

                                 SharedPreferences prefs1 = await SharedPreferences.getInstance();
                                 final phone = prefs1.setString('phone', number.text );

                                 print(phone);
                                 print("aryamansr");
                                 // Navigator.push(context, MaterialPageRoute(builder: (context) =>BottomNavigation()));
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
  Contact(String  name, String  number, String email,) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse(ApiConst.baseurl+"user_contact"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name":name,
        "user_id":"$userId",
        "email":email,
        "phone":number,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == "200") {
      final userId = data['id'];
      Fluttertoast.showToast(
          msg: "Contact Add SuccessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0).whenComplete(() =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>BottomNavigation()
            )
           )
          );
      print("Contact Add SuccessFully");
    } else {
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print("hii");
    }
  }
}