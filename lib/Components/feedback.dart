import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import '../Constant/color.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   leading: IconButton(onPressed: () {
          //     Navigator.pop(context);
          //   }, icon: Icon(Icons.arrow_back_ios)),
          //   title: (choosenLanguage != '') ?
          //   Text(languages[choosenLanguage]['feedback']) : Container(),
          //   centerTitle: true,
          //   backgroundColor: PinkColors,
          // ),
          body: Tawk(
            directChatLink: 'https://docs.google.com/forms/d/e/1FAIpQLScJHtiYx4F8bKr8oaSSNDaHWQE8c3ytCTl72dmCKoz00wl3wg/viewform',
            placeholder:  Center(
              child: CircularProgressIndicator(color: PinkColors),
            ),
          )
      ),
    );
  }
}
