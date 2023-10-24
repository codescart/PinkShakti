
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Screens/Auth/otp.dart';
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RegisterForm extends StatefulWidget {

  const RegisterForm({
    Key? key,
    required this.isLogin,
    required this.animationDuration,
    required this.size,
    required this.defaultLoginSize,
  }) : super(key: key);

  final bool isLogin;
  final Duration animationDuration;
  final Size size;
  final double defaultLoginSize;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final TextEditingController name=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController _phone=TextEditingController();
  final TextEditingController age=TextEditingController();
  final TextEditingController addre=TextEditingController();
  // final TextEditingController _pincode=TextEditingController();

  String ?_district ;
  List _districtlist = [];

  String ? _zipcode ;
  List _ziplist = [];

  @override
  void initState() {
    super.initState();
    _districtData();
  }



  Future<String> _districtData() async {
    final res = await http.get(
        Uri.parse(ApiConst.baseurl+'district_list')
    );
    final resBody = json.decode(res.body)["country"];
    print(resBody);
    print("resBody");

    setState(() {
      _districtlist = resBody;
    });
    return "Success";
  }

  Future<String> _zipCode(String? companys) async {
    print("hii"+companys.toString());
    final res = await http.get(
        Uri.parse(ApiConst.baseurl+'all_zip?district_id=$companys')
    );
    final resBody = json.decode(res.body)["data"];
    print(resBody);
    print("resBody");
    setState(() {
      _ziplist = resBody;
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.isLogin ? 0.0 : 1.0,
      duration: widget.animationDuration * 5,
      child: Visibility(
        visible: !widget.isLogin,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: widget.size.width,
            height: widget.defaultLoginSize,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // const SizedBox(height: 10),
                  // (choosenLanguage != '') ? Text(
                  //   languages[choosenLanguage]['Welcome'],
                  //   style: GoogleFonts.roboto(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 24
                  //   ),
                  // ):Container(),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/logo.png',height: 200,width: 200,),
                  const SizedBox(height: 20),
                  (choosenLanguage != '') ?  InputContainer(
                      child: TextField(
                       controller: name,
                        cursorColor: PinkColors,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person, color: PinkColors
                          ),
                          hintText: languages[choosenLanguage]['Name'],hintStyle: GoogleFonts.roboto(),
                          border: InputBorder.none,
                        ),
                      )
                  ):Container(),
                  const SizedBox(height: 5),
                  (choosenLanguage != '') ?  InputContainer(
                      child: TextField(
                        controller: email,
                        cursorColor: PinkColors,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.mail, color: PinkColors
                          ),
                          hintText: languages[choosenLanguage]['Email'],hintStyle: GoogleFonts.roboto(),
                          border: InputBorder.none,
                        ),
                      )
                  ):Container(),
                  const SizedBox(height: 5),
                  (choosenLanguage != '') ?  InputContainer(
                      child: TextField(
                        keyboardType: TextInputType.number,
                         maxLength: 10,
                        controller: _phone,
                        cursorColor: PinkColors,
                        decoration: InputDecoration(
                          counterText: '',
                          icon: const Icon(Icons.phone_android_sharp, color: PinkColors
                          ),
                          hintText: languages[choosenLanguage]['Mobile Number'],hintStyle: GoogleFonts.roboto(),
                          border: InputBorder.none,
                        ),
                      )
                  ):Container(),
                  const SizedBox(height: 5),
                  (choosenLanguage != '') ?  InputContainer(
                      child: TextField(
                        // maxLines: 5,
                        controller: age,
                        cursorColor: PinkColors,
                        maxLength: 2,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          icon: const Icon(Icons.apps_outage_rounded, color: PinkColors
                          ),
                          hintText: languages[choosenLanguage]['Age'],hintStyle: GoogleFonts.roboto(),
                          border: InputBorder.none,
                        ),
                      )
                  ):Container(),
                  const SizedBox(height: 10),
                  (choosenLanguage != '') ?  InputContainer(
                      child: TextField(
                        controller: addre,
                        cursorColor: PinkColors,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          counterText: '',
                          icon: const Icon(Icons.pin_drop, color: PinkColors
                          ),
                          hintText: languages[choosenLanguage]['Address'],hintStyle: GoogleFonts.roboto(),
                          border: InputBorder.none,
                        ),
                      )
                  ):Container(),
                  const SizedBox(height: 10),
                  (choosenLanguage != '') ?  InputContainer(
                      child: DropdownButtonHideUnderline(
                        child:DropdownButton(
                          hint:Text(
                            'Select District',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: _districtlist
                              .map((item) =>
                              DropdownMenuItem<String>(
                                value:item['id'].toString(),
                                child: Text(
                                  item['district'].toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                              .toList(),
                          value: _district,
                          onChanged: (value) async{
                            setState(() {
                              _district = value as String;
                            });
                            _zipCode(_district);
                          },
                          // buttonHeight: 40,
                          // buttonWidth: 140,
                          // itemHeight: 40,
                        ),
                      ),
                      // TextField(
                      //   controller: _pincode,
                      //   cursorColor: PinkColors,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //     icon: ImageIcon(
                      //       AssetImage('assets/mpin.png'),
                      //       color: PinkColors,
                      //     ),
                      //     hintText: languages[choosenLanguage]['pin'],hintStyle: GoogleFonts.roboto(),
                      //     border: InputBorder.none,
                      //   ),
                      // )
                  ):Container(),
                  const SizedBox(height: 10),
                  (choosenLanguage != '') ?  InputContainer(
                    child: DropdownButtonHideUnderline(
                      child:DropdownButton(
                        hint:Text(
                          'Select Zipcode',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme
                                .of(context)
                                .hintColor,
                          ),
                        ),
                        items: _ziplist
                            .map((items) =>
                            DropdownMenuItem<String>(
                              value:items['id'].toString(),
                              child: Text(
                                items['Pincode'].toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                            .toList(),
                        value: _zipcode,
                        onChanged: (value) {
                          setState(() {
                            _zipcode = value as String;
                          });
                        },

                        // buttonHeight: 40,
                        // buttonWidth: 140,
                        // itemHeight: 40,
                      ),
                    ),


                    // TextField(
                    //   controller: _pincode,
                    //   cursorColor: PinkColors,
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     icon: ImageIcon(
                    //       AssetImage('assets/mpin.png'),
                    //       color: PinkColors,
                    //     ),
                    //     hintText: languages[choosenLanguage]['pin'],hintStyle: GoogleFonts.roboto(),
                    //     border: InputBorder.none,
                    //   ),
                    // )
                  ):Container(),
                  const SizedBox(height: 10),
                  (choosenLanguage != '') ?  Container(
                    width: 290,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 12,
                          backgroundColor: PinkColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences prefsssssss = await SharedPreferences.getInstance();
                          prefsssssss.setString('email', email.text);
                          SharedPreferences phhhone = await SharedPreferences.getInstance();
                          phhhone.setString('phhone', _phone.text);
                          SharedPreferences Adresss = await SharedPreferences.getInstance();
                          Adresss.setString('Adres', addre.text);
                          Register(name.text,email.text,_phone.text,age.text,addre.text);
                        }, child: Text(languages[choosenLanguage]['text_sign_up'])),
                  ):Container(),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Register(String  name, String email, String _phone, String age,String address) async {
    final response = await http.post(
      Uri.parse(ApiConst.baseurl+"regii"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
          "name":name,
          "email":email,
          "mobile":_phone,
          "age":age,
          "address":address,
          "zip":_zipcode.toString(),
        "district":_district.toString()              ,
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    print("aaaaaaaaaaa");
    if (data['error'] == "200") {
      final userId = data["data"]['id'];
      final userName = data["data"]['name'];
      Fluttertoast.showToast(
          msg: "Otp Sent On Your Phone",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0).whenComplete(() =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>OTPScreens(phoneNo: _phone, userId: userId, userName: userName,))));
          // print("Register SuccessFully");
    }
    else {
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
}