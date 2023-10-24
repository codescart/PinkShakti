import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinkPower/Screens/Auth/components/registerpage.dart';
import 'package:pinkPower/Screens/Auth/otp.dart';
import '../../Components/input_container.dart';
import '../../Components/rounded_button.dart';
import '../../Constant/api.dart';
import '../../Constant/color.dart';
import '../../Language/function.dart';
import '../../Language/translation.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phone = TextEditingController();
  bool _isLoadingButton = false;
  GlobalKey<FormState> _formKey = GlobalKey();
  FocusNode focusNode = FocusNode();

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
                Form(
                  key: _formKey,
                  child: InputContainer(
                      child:IntlPhoneField(
                        focusNode: focusNode,
                        showDropdownIcon: false,
                        disableLengthCheck: true,
                        controller: _phone,
                        textAlignVertical: TextAlignVertical.bottom,
                        cursorColor: PinkColors,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        languageCode: "en",
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                        onCountryChanged: (country) {
                          print('Country changed to: ' + country.name);
                        },
                      ),
                  ),
                ),
                SizedBox(
                  height: heights / 40,
                ),
                InkWell(
                    onTap: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RegisterPage(phoneno: _phone.text,)));
                      login(_phone.text);
                    },
                    child: RoundedButton(child: setUpButtonChild())),
                SizedBox(
                  height: heights / 10,
                ),
              ],
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
                child: Text(
                  languages[choosenLanguage]['welcome_to'],
                  style: const TextStyle(color: PinkColors, fontSize: 18),
                )),
          )
        : Container();
  }

  login(
    String _phone,
  ) async {
    setState(() {
      _isLoadingButton = true;
    });
    final response = await http.post(
      Uri.parse(ApiConst.baseurl + "login"),
      headers:{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "mobile": _phone
      }),
    );
    final data = jsonDecode(response.body);
    if (data["status"] == "200") {
      setState(() {
        _isLoadingButton = false;
      });
      final userId = data['data']['id'];
      final userName = data['data']['name'];
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => OTPScreens(
                  phoneNo: _phone, userId: userId, userName: userName)));
    }
    else if(data["status"] == "500"){
      setState(() {
        _isLoadingButton = false;
      });
      // Fluttertoast.showToast(
      //     msg: data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: purple,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterPage(phoneno: _phone,)));
    }
    else {
      setState(() {
        _isLoadingButton = false;
      });
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: purple,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget setUpButtonChild() {
    if (_isLoadingButton == false) {
      return Text(
          (choosenLanguage != '') ? languages[choosenLanguage]['Login'] : "",
          style: TextStyle(fontSize: 25 ,color:whiteColor ));
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }
}
