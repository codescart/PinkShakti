import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Screens/Auth/loginpage.dart';
import 'package:pinkPower/Screens/Auth/otp.dart';
import '../../../Components/input_container.dart';
import '../../../Components/rounded_button.dart';
import '../../../Constant/api.dart';
import '../../../Constant/color.dart';
import 'package:http/http.dart' as http;
import '../../../Language/function.dart';
import '../../../Language/translation.dart';

class RegisterPage extends StatefulWidget {
  final String phoneno;
  const RegisterPage({Key? key, required this.phoneno}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   TextEditingController _name = TextEditingController();
   TextEditingController _phone = TextEditingController();
  bool _isLoadingButton = false;

  @override
  void initState() {
    _phone.text=widget.phoneno.toString();
    super.initState();
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
                    borderRadius: BorderRadius.circular(50), color: purple),
              )),
          Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 190,
                height: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: PinkColors),
              )),
          buildContant(),
          buildContainer()
        ],
      ),
    );
  }

  Widget buildContant() {
    final heights = MediaQuery.of(context).size.height;
    return (choosenLanguage != '')
        ? Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                scale: 3,
              ),
              SizedBox(
                height: heights / 25,
              ),
              InputContainer(
                  child: TextField(
                    readOnly: true,
                    controller: _phone,
                    keyboardType: TextInputType.number,
                    cursorColor: PinkColors,
                    decoration: InputDecoration(
                      counterText: '',
                      icon: Icon(Icons.phone_android, color: PinkColors
                      ),
                      hintText: languages[choosenLanguage]['Mobile Number'],
                      hintStyle: GoogleFonts.roboto(),
                      border: InputBorder.none,
                    ),
                  )
              ),
              SizedBox(
                height: heights / 40,
              ),
              InputContainer(
                  child: TextField(
                    maxLength: 10,
                    controller: _name,
                    keyboardType: TextInputType.text,
                    cursorColor: PinkColors,
                    decoration: InputDecoration(
                      counterText: '',
                      icon: Icon(Icons.person, color: PinkColors
                      ),
                      hintText: languages[choosenLanguage]['Name'],
                      hintStyle: GoogleFonts.roboto(),
                      border: InputBorder.none,
                    ),
                  )
              ),
              SizedBox(
                height: heights / 40,
              ),
              InkWell(
                  onTap: () {
                    _register(_name.text);
                  },
                  child: RoundedButton(child: setUpButtonChild())),
              SizedBox(
                height: heights / 10,
              ),
            ],
          ),
        ))
        : Container();
  }

  Widget buildContainer() {
    final heights = MediaQuery.of(context).size.height;
    final widths = heights * 2.2;
    return (choosenLanguage != '')
        ? Align(
      alignment: Alignment.bottomCenter,
      child: Container(
          width: widths,
          height: heights * 0.1,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
              color: kBackgroundColor),
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginPage()));
            }, child: Text(
            languages[choosenLanguage]['text_login'],
            style: const TextStyle(
                color: PinkColors,
                fontSize: 18
            ),
          ),
          ),
      ),
    )
        : Container();
  }

  _register(String _name) async {
    setState(() {
      _isLoadingButton = true;
    });
    final response = await http.post(
      Uri.parse(ApiConst.baseurl+"userregister"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name":_name,
        "mobile":widget.phoneno,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print("aaaaaaaaaaa");
    if (data['status'] == "200") {
      setState(() {
        _isLoadingButton = false;
      });
      final userId = data["data"]['id'];
      final userName = data["data"]['name'];
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0).whenComplete(() =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>OTPScreens(phoneNo: widget.phoneno, userId: userId, userName: userName,))));
      // print("Register SuccessFully");
    }
    else {
      setState(() {
        _isLoadingButton = false;
      });
      Fluttertoast.showToast(
          msg: "Email or Mobile No already exists",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      // print("hii");
    }
  }

  Widget setUpButtonChild() {
    if (_isLoadingButton == false) {
      return Text(
          (choosenLanguage != '') ? languages[choosenLanguage]['register'] : "",
          style: TextStyle(fontSize: 25 ,color:whiteColor ));
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }
}
