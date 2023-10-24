import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Screens/Auth/login.dart';
import 'package:pinkPower/Screens/Auth/loginpage.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _redirection();
    super.initState();
  }

  _redirection()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    Timer(Duration(seconds: 4),
            ()=>userId == null?Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginPage())):Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BottomNavigation()))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Container(
          child: Image.asset('assets/images/logonn.png'),
        ),
      ),
    );
  }
}



