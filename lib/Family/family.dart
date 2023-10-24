import 'package:flutter/material.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/family/contactlist.dart';
import 'package:pinkPower/family/newcontact.dart';
import '../Language/function.dart';
import '../Language/translation.dart';


class Family extends StatefulWidget {

  @override
  _FamilyState createState() => _FamilyState();
}
class _FamilyState extends State<Family> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color:  purple,
                    ),
                    child: TabBar(
                      indicator: const BoxDecoration(
                        color: PinkColors,
                      ) ,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs:    [
                        (choosenLanguage != '') ? Tab(text:languages[choosenLanguage]['CONTACT'],):Container(),
                        (choosenLanguage != '') ? Tab(text:languages[choosenLanguage]['ADD NEW CONTACT'],):Container(),
                      ],
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                        children:  [
                          ContactList(),
                          NewContact(),
                        ],
                      )
                  )
                ],
              ),
            )
        ),
      )
    );
  }
}