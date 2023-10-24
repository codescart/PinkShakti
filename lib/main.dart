import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pinkPower/Screens/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Language/function.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _savelanguage();
  }

  var lan;
  _savelanguage()async{
    final prefs= await SharedPreferences.getInstance();
    lan= await prefs.getString('choosenlan')??'en';
    setState(() {
      choosenLanguage = lan;
      languageDirection = 'ltr';
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashScreen()
    );
  }
}
