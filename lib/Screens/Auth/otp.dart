import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinkPower/Screens/Auth/login.dart';
import 'package:pinkPower/Screens/Permisions/permisions.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';


class OTPScreens extends StatefulWidget {
  final String phoneNo;
  final String userId;
  final String userName;

    OTPScreens({required this.phoneNo, required this.userId, required this.userName});

  @override
  _OTPScreensState createState() => _OTPScreensState();
}

class _OTPScreensState extends State<OTPScreens> {
  final int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");
  String _verificationCode = "";

  @override
  void initState() {
    _verifyPhone();
    _getSignatureCode();
    _startListeningSms();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    print("lllllllllll");
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }


  _onSubmitOtp() async {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) async {
    setState(() {
      _otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }
  _verifyOtpCode() async {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(seconds:5), () async {
      setState(() {
        _isLoadingButton = false;
        _enableButton = false;
      });

      try {
        await FirebaseAuth.instance
            .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: _verificationCode, smsCode: _otpCode))
            .then((value) async {
          if (value.user != null) {
            final prefs1 = await SharedPreferences.getInstance();
            final key1 = 'userId';
            final userId = widget.userId;
            prefs1.setString(key1, userId);
            final prefs = await SharedPreferences.getInstance();
            final key = 'userName';
            final userName= widget.userName;
            prefs.setString(key, userName);
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PermissionScreen()));
          }
        });
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
               SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
                Container(
                height: 300,
                width: 300,
                child: Image.asset('assets/images/otp.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (choosenLanguage != '') ?   Text(
                    languages[choosenLanguage]['OTP Verification to this number'] +" +91 "+"${widget.phoneNo}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ):Container(),
                  IconButton(
                      color:PinkColors,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
                      }, icon:Icon(Icons.edit)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldPin(
                  textController: textEditingController,
                  autoFocus: true,
                  codeLength: _otpCodeLength,
                  alignment: MainAxisAlignment.center,
                  defaultBoxSize: 40.0,
                  margin: 5,
                  selectedBoxSize: 40.0,
                  textStyle: const TextStyle(fontSize: 20),
                  defaultDecoration: _pinPutDecoration.copyWith(
                      border: Border.all(
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.6))),
                  selectedDecoration: _pinPutDecoration,
                  onChange: (code) {
                    _onOtpCallBack(code, false);
                  }),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 12,
                  child: InkWell(
                    onTap: _enableButton ? _onSubmitOtp : null,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: PinkColors
                      ),
                      child: _setUpButtonChild(),
                    ),
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91${widget.phoneNo}',
      verificationCompleted: (PhoneAuthCredential credential) {
        // final prefs1 = await SharedPreferences.getInstance();
        // final key1 = 'userId';
        // final userId = widget.userId;
        // prefs1.setString(key1, userId);
        // final prefs = await SharedPreferences.getInstance();
        // final key = 'userName';
        // final userName= widget.userName;
        // prefs.setString(key, userName);
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) =>  PermissionScreen()));
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) =>  BottomNavigation(pageIndex: 0,)));
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );

  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return const SizedBox(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text((choosenLanguage != '') ?
      languages[choosenLanguage]['Verify']:"",
        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
      );
    }
  }
}