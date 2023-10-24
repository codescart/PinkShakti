import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:pinkPower/Screens/updateprofile.dart';
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {

  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = Duration(milliseconds: 270);

  @override
  void initState() {
   Profile();
    animationController = AnimationController(vsync: this, duration: animationDuration);
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    color: purple,

                ),
              )
          ),
          Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 190,
                height: 190,
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
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));

                  // Navigator.pop(context);
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
            alignment: Alignment.center,
            child:  Container(
              child:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // (choosenLanguage != '') ?
                    // Text(
                    //   languages[choosenLanguage]['Profile page'],
                    //   style: GoogleFonts.roboto(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 24
                    //   ),
                    // ):Container(),
                    const SizedBox(height: 40),
                    SizedBox(
                   height: 115,
                   width: 115,
                     child: Stack(
                     clipBehavior: Clip.none,
                        fit: StackFit.expand,
                     children: [
                       data == null?CircleAvatar(
                         backgroundColor: Colors.white,
                       ):data["img_url"]==null?CircleAvatar(
                         backgroundColor: Colors.white,
                         backgroundImage:AssetImage('assets/images/gprofile.png'),
                       ):CircleAvatar(
                        backgroundColor:  faceColor,
                         backgroundImage:NetworkImage("https://ladli.wishufashion.com/api/uploads/"+data["img_url"].toString()),
                       ),
                   ],
                  ),
                 ),
                   const SizedBox(height: 30),
                    InputContainer(
                    child: TextField(
                      readOnly:  true,
                      cursorColor: PinkColors,
                      decoration: InputDecoration(
                        icon: const Icon(
                            Icons.person, color: PinkColors
                        ),
                        hintText: data==null?"":data["name"].toString(),hintStyle: GoogleFonts.roboto(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    )
                ),
                   const SizedBox(height: 5),
                    InputContainer(
                        child: TextField(
                          readOnly:  true,
                          cursorColor: PinkColors,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.mail, color: PinkColors
                            ),
                           hintText: data==null?"":data["email"].toString(),hintStyle: GoogleFonts.roboto(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        )
                    ),

                   const SizedBox(height: 5),
                    InputContainer(
                        child: TextField(
                          readOnly:  true,
                          cursorColor: PinkColors,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.phone_android_sharp, color: PinkColors
                            ),
                            hintText: data==null?"":data["mobile"].toString(),hintStyle: GoogleFonts.roboto(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                   const SizedBox(height: 5),

                    InputContainer(
                        child: TextField(
                          readOnly:  true,
                          cursorColor: PinkColors,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.apps_outage_rounded, color: PinkColors
                            ),
                            hintText: data==null?"":data["age"].toString(),hintStyle: GoogleFonts.roboto(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                 const   SizedBox(height: 5),
                    InputContainer(
                        child: TextField(
                          readOnly:  true,
                          cursorColor: PinkColors,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.location_on, color: PinkColors
                            ),
                            hintText: data==null?"":data["address"].toString(),hintStyle: GoogleFonts.roboto(color: Colors.black),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                   const SizedBox(height: 20),
                      (choosenLanguage != '') ?
                        Container(
                        width:  MediaQuery.of(context).size.width*0.80,
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>EditProfile(
                                  image: data["img_url"].toString(),
                                  name: data["name"].toString(),
                                  email:data["email"].toString(),
                                  phone:data["mobile"].toString(),
                                  age:data["age"].toString(),
                                  address:data["address"].toString()
                              )));
                            }, child: Text( languages[choosenLanguage]['Edit Profile'],
                          style: const TextStyle(fontSize: 25)
                          ,)
                        )
                    ):Container(),
                  ],
                ),
              ),
            ),
          ),
         ],
      ),
    );
  }
  var datad;
  var data;
  var datal;
   Profile() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse(ApiConst.baseurl+'user_get'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$userId",
      }),
    );
    var datad = jsonDecode(response.body);
    print(datad);
    print('sssssssssss');
    if (datad['error'] == "200") {
      setState(() {
        datal=json.decode(response.body)['data'];
        data=datal[0];
      });
    }
  }

}
