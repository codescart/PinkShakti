import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Screens/Auth/login.dart';
import 'package:pinkPower/Screens/aboutus.dart';
import 'package:pinkPower/Language/changelanguage.dart';
import 'package:http/http.dart' as http;
import 'package:pinkPower/Screens/privacypolicy.dart';
import 'package:pinkPower/Screens/profilescreen.dart';
import 'package:pinkPower/Screens/redirections.dart';
import 'package:pinkPower/Screens/reportcrime.dart';
import 'package:pinkPower/Screens/termsconditions.dart';
import 'package:pinkPower/components/feedback.dart';
import 'package:pinkPower/components/homeMap.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Profile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
              DrawerHeader(
              decoration: const BoxDecoration(
                color: PinkColors,
              ),
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(color: PinkColors),
                accountName: Text(
                  data==null?"":data["name"].toString(),
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text(data==null?"":data["email"].toString(),),
                currentAccountPictureSize: const Size.square(55),
                currentAccountPicture:   data==null? const CircleAvatar(
                     backgroundImage:AssetImage('assets/images/gprofile.png'),
                  ):SizedBox(
                  height:100,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage("https://ladli.wishufashion.com/api/uploads/"+data["img_url"].toString(),) ,
                  ),
                ), //Text
                )
              ),
            (choosenLanguage != '') ?   ListTile(
              leading: const Icon(Icons.home,color:PinkColors,size: 35,),
              title:   Text( languages[choosenLanguage]['Home'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
              onTap: () {
                Navigator.pop(context);
              },
            ):Container(),
            (choosenLanguage != '') ?  ListTile(
              leading: const Icon(Icons.person,color:PinkColors,size: 35,),
              title: Text(languages[choosenLanguage]['Profile'],
                  style: GoogleFonts.roboto(
                  fontSize: 16,fontWeight: FontWeight.w700
                  )
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ProfileScreen()));
               },
            ):Container(),
            (choosenLanguage != '') ?  ListTile(
              leading: const Icon(Icons.call,color:PinkColors,size: 35,),
              title: Text(languages[choosenLanguage]['Call112'],
                  style: GoogleFonts.roboto(
                      fontSize: 16,fontWeight: FontWeight.w700
                  )
              ),
              onTap: () {
                FlutterPhoneDirectCaller.callNumber("112");
              },
            ):Container(),
            (choosenLanguage != '') ?  ListTile(
              leading: const Icon(Icons.call,color:PinkColors,size: 35,),
              title: Text(languages[choosenLanguage]['Call1090'],
                  style: GoogleFonts.roboto(
                      fontSize: 16,fontWeight: FontWeight.w700
                  )
              ),
              onTap: () {
                FlutterPhoneDirectCaller.callNumber("1090");
              },
            ):Container(),
            (choosenLanguage != '') ?   ListTile(
              leading: const  Icon(Icons.report,color:PinkColors,size: 35,),
              title:   Text(languages[choosenLanguage]['Report Share Crime'],
                  style: GoogleFonts.roboto(
                  fontSize: 16,fontWeight: FontWeight.w700) ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>ReportCrime()));
              },
            ):Container(),
            (choosenLanguage != '') ?  ListTile(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(
                    builder: (context)=>Redirections()
                )
                );
              },
              leading: const Icon(Icons.info,color:PinkColors,size: 35,),
              title:   Text(languages[choosenLanguage]['Redirections'], style: GoogleFonts.roboto(
                  fontSize: 16,fontWeight: FontWeight.w700) ),
            ):Container(),
            (choosenLanguage != '') ?   ListTile(
              leading: const Icon(Icons.people_alt_rounded,color:PinkColors,size: 35,),
              title: Text(
                  languages[choosenLanguage]['About Us'],
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  )
              ),
              onTap: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutUs()));
              },
            ):Container(),
            (choosenLanguage != '') ?   ListTile(
              leading: const  Icon(Icons.language,color:PinkColors,size: 35,),
              title:   Text(languages[choosenLanguage]['Change Language'],
                  style: GoogleFonts.roboto(
                      fontSize: 16,fontWeight: FontWeight.w700) ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeLanguage()));              },
            ):Container(),
            (choosenLanguage != '') ?   ListTile(
              leading: const  Icon(Icons.feed_outlined,color:PinkColors,size: 35,),
              title:   Text(languages[choosenLanguage]['feedback'],
                  style: GoogleFonts.roboto(
                      fontSize: 16,fontWeight: FontWeight.w700) ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FeedBack()));
                },
            ):Container(),

            (choosenLanguage != '') ?   ListTile(
              leading: const Icon(Icons.privacy_tip,color:PinkColors,size: 35,),
              title:   Text(languages[choosenLanguage]['Privacy policy'],
                  style: GoogleFonts.roboto(
                      fontSize: 16,fontWeight: FontWeight.w700) ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PrivacyPolicy()));
              },
            ):Container(),

            (choosenLanguage != '') ?   ListTile(
              leading:  const Icon(Icons.report,color:PinkColors,size: 35,),
              title:   Text(languages[choosenLanguage]['Terms & Conditions'],
                  style: GoogleFonts.roboto(
                      fontSize: 16,fontWeight: FontWeight.w700) ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsConditions()));
              },
            ):Container(),

            const  SizedBox(height: 20,),
            (choosenLanguage != '') ?   ListTile(
              title: Center(
                // padding: EdgeInsets.only(left: 30),
                child: Text(languages[choosenLanguage]['allRights'], style: GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.w700) ),
              )
            ):Container(),

          const  SizedBox(height: 20,),
            (choosenLanguage != '') ?  Container(
              child: ListTile(
                title: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.logout,
                    color: whiteColor,
                    size: 25.0,
                  ),
                  label:   Text(languages[choosenLanguage]['Log Out'], style: GoogleFonts.roboto(color: whiteColor) ),
                  onPressed: () async {
                    final prefs = await SharedPreferences.getInstance();
                    prefs.remove('userId');
                    prefs.remove('userName');
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 12,
                    backgroundColor: PinkColors,
                    shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                  ),
                ),
              ),
            ):Container(),
          ],
        ),
      ),
      body: HomeMapPage(),
      //AddAddress(),
    );
  }

  var datad;
  var data;
  var datal;
  Future Profile() async {
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

