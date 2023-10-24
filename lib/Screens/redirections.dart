import 'package:flutter/material.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/redirctions/gov_policies.dart';
import 'package:pinkPower/redirctions/state_women_commission.dart';
import 'package:pinkPower/redirctions/women_crime_laws.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:url_launcher/url_launcher.dart';

class Redirections extends StatefulWidget {
  const Redirections({Key? key}) : super(key: key);

  @override
  State<Redirections> createState() => _RedirectionsState();
}

class _RedirectionsState extends State<Redirections> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   leading: IconButton(onPressed: (){
      //     Navigator.pop(context);
      //   }, icon: Icon(Icons.arrow_back_ios)),
      //   title: (choosenLanguage != '') ?
      //   Text(languages[choosenLanguage]['Redirections']):Container(),
      //   backgroundColor: PinkColors,
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Positioned(
              top: 100,
              right: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
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
              bottom: -50,
              right: -50,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: PinkColors,

                ),
              )
          ),
          Positioned(
              bottom: 90,
              left: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: purple
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
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (choosenLanguage != '') ?  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 12,
                      child: InkWell(
                        onTap: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Gov_Policies()));
                        },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:  faceColor
                          ),
                          child: Center(child: Text(languages[choosenLanguage]['GovtPolicies'],style: TextStyle(fontSize: 20,color: Colors.white),)),
                        ),
                      )
                  ):Container(),
                  SizedBox(height: 20,),
                  (choosenLanguage != '') ?   Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 12,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Women_Crime_Laws()));               },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: faceColor
                          ),
                          child: Center(
                              child: Text(languages[choosenLanguage]['WomenCrimeLaws'],style: TextStyle(fontSize: 20,color: Colors.white),)),
                        ),
                      )
                  ):Container(),
                  SizedBox(height: 20,),
                  (choosenLanguage != '') ?  Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 12,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>State_Women_Commi()));                },
                        child: Container(
                          height: 50,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color:  faceColor
                          ),
                          child: Center(child: Text(languages[choosenLanguage]['State Women Commission'],style: TextStyle(fontSize: 20,color: Colors.white),)),
                        ),
                      )
                  ):Container(),
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}
