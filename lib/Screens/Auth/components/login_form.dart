import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Screens/Auth/otp.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:http/http.dart' as http;


class LoginForm extends StatefulWidget {
  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;
    LoginForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _phone = TextEditingController();

  bool _isLoadingButton = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 1.0 : 0.0,
      duration: widget.animationDuration * 4,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.size.width,
          height: widget.defaultLoginSize,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // (choosenLanguage != '') ?
                // Text(
                //   languages[choosenLanguage]['Welcome Back'],
                //     style: GoogleFonts.roboto(
                //         fontWeight: FontWeight.bold,
                //         fontSize: 24
                //     ),
                // ):Container(),
                SizedBox(height: 150),
                Image.asset('assets/images/logo.png'),
                SizedBox(height: 40),
                (choosenLanguage != '') ? InputContainer(
                    child: TextField(
                      maxLength: 10,
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
                ) : Container(),
                SizedBox(height: 10),

                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.80,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // elevation: 12,
                        backgroundColor: PinkColors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () {
                        login(_phone.text);
                      },
                      child: setUpButtonChild()
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login(String _phone,) async {
    setState(() {
      _isLoadingButton = true;
    });
    final response = await http.post(
      Uri.parse(ApiConst.baseurl + "otpphone"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "phone": _phone
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print('xxxxxx');
    if (data["error"] == "200") {
      setState(() {
        _isLoadingButton = false;
      });
      final userId = data['data']['id'];
      final userName = data['data']['name'];
      // Fluttertoast.showToast(
      //     msg: "OTP send on your given phone No.",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: PinkColors,
      //     textColor: Colors.white,
      //     fontSize: 14.0);
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) =>
              OTPScreens(
                  phoneNo: _phone, userId: userId, userName: userName
              )
      )
      );
    } else {
      setState(() {
        _isLoadingButton = false;
      });
      Fluttertoast.showToast(
          msg: "Please Register",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: purple,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
  Widget setUpButtonChild() {
    if (_isLoadingButton==false) {
      return  Text((choosenLanguage != '')?languages[choosenLanguage]['Login']:"",
          style: TextStyle(fontSize: 25)
      );
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }
}

