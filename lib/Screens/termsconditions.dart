import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsConditions extends StatefulWidget {
  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> with SingleTickerProviderStateMixin {

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
      appBar: AppBar(
        title: (choosenLanguage != '') ?
        Text(
            languages[choosenLanguage]['Terms & Conditions'],
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
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['ACCEPTANCE'],textAlign: TextAlign.justify,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: purple)):Text(""),
                      SizedBox(height: 10,),
                      (choosenLanguage != '') ?Text(languages[choosenLanguage]['ACCEPTANCEC'],textAlign: TextAlign.justify,style: GoogleFonts.roboto()):Text(""),
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
  Future<List<Contact>> getPostApi() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final resposne = await http.post(
      Uri.parse( ApiConst.baseurl + 'term_condition'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var data = jsonDecode(resposne.body.toString())['country'];
    List<Contact> postList = [];
    for (var o in data)  {
      Contact al = Contact(
        o["id"],
        o["term_condition"],
      );
      postList.add(al);
    }
    return postList;
  }
}
class Contact {
  String? id;
  String? term_condition;
  Contact(
      this.id,
      this.term_condition,
      );
}