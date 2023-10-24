import 'package:flutter/material.dart';
import 'package:pinkPower/family/family.dart';
import 'package:pinkPower/Screens/homedrawer.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavigation extends StatefulWidget {
  final int ?pageIndex;
  BottomNavigation({Key? key, this.pageIndex,}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int pageIndex = 0;

  @override
  void initState() {
    setState(() {
      pageIndex=widget.pageIndex ??0;
    });
    super.initState();
  }
  final pages = [
       HomePage(),
       Family(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }
  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color:  PinkColors,
        borderRadius: const BorderRadius.only(
          // topLeft: Radius.circular(20),
          // topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
           onTap: () {
            setState(() {
              pageIndex = 0;
            });
          },
            child: Container(
              width: MediaQuery.of(context).size.width*0.5,
              child: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    setState(() {
                      pageIndex = 0;
                    });
                  },
                  icon: pageIndex == 0
                      ?Text( (choosenLanguage != '') ? languages[choosenLanguage]['MAP']:"",
                    style: const TextStyle(color: whiteColor,fontSize: 20),)
                      : const Icon(
                    Icons.location_on,
                    color: whiteColor,
                    size: 35,
                  ) ,
                ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                pageIndex = 1;
              });
            },
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width*0.5,
              decoration: const BoxDecoration(
                  color: purple,
                 // borderRadius: BorderRadius.only(topRight: Radius.circular(20))
              ),
              child: IconButton(
                enableFeedback: false,
                onPressed: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                icon: pageIndex == 1
                    ?Text((choosenLanguage != '') ? languages[choosenLanguage]['FAMILY']:"",
                  style: const TextStyle(color: whiteColor,fontSize: 20),)
                    : const Icon(
                  Icons.people_alt,
                  color: whiteColor,
                  size: 35,
                ) ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
