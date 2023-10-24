import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewContact extends StatefulWidget {
  const NewContact({Key? key}) : super(key: key);

  @override
  State<NewContact> createState() => _NewContactState();
}

class _NewContactState extends State<NewContact> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // final FlutterContactPicker _contactPicker = new FlutterContactPicker();
  // var FullName;
  // var ContectNumber;
  // Future<void> _selectContact() async {
  //   Contact? contact = await _contactPicker.selectContact();
  //   // print('Name: ${contact!.fullName}');
  //   // print('Phone: ${contact.phoneNumbers}');
  //   if (contact!.phoneNumbers![0] != null) {
  //     setState(() {
  //       FullName = contact.fullName;
  //       nameController.text = FullName;
  //       numController.text = ContectNumber;
  //       ContectNumber = contact.phoneNumbers![0];
  //     });
  //     print('Name: ${contact.fullName}');
  //     print('Phone: ${contact.phoneNumbers![0]}');
  //   }
  // }

  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          // (choosenLanguage != '')
          //     ? Container(
          //         height: 50,
          //         width: MediaQuery.of(context).size.width * 0.75,
          //         margin: EdgeInsets.only(bottom: 10),
          //         child: ElevatedButton(
          //             style: ElevatedButton.styleFrom(
          //               elevation: 12,
          //               backgroundColor: PinkColors,
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(20.0),
          //               ),
          //             ),
          //             onPressed: _selectContact,
          //             child: Text(languages[choosenLanguage]['addfromcontact'],
          //                 style: const TextStyle(fontSize: 15))))
          //     : Container(),
          SizedBox(height: 30),
          (choosenLanguage != '')
              ? InputContainer(
                  child: TextField(
                  controller: nameController,
                  cursorColor: PinkColors,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.person, color: PinkColors),
                    hintText: languages[choosenLanguage]['Name'],
                    hintStyle: GoogleFonts.roboto(),
                    border: InputBorder.none,
                  ),
                ))
              : Container(),
          (choosenLanguage != '')
              ? InputContainer(
                  child: TextField(
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  controller: numController,
                  cursorColor: PinkColors,
                  decoration: InputDecoration(
                    counterText: '',
                    icon: const Icon(
                      Icons.phone_android_rounded,
                      color: PinkColors,
                    ),
                    hintText: languages[choosenLanguage]['Mobile Number'],
                    hintStyle: GoogleFonts.roboto(),
                    border: InputBorder.none,
                  ),
                ))
              : Container(),
          (choosenLanguage != '')
              ? InputContainer(
                  child: TextField(
                  controller: emailController,
                  cursorColor: PinkColors,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.mail, color: PinkColors),
                    hintText: languages[choosenLanguage]['Email'],
                    hintStyle: GoogleFonts.roboto(),
                    border: InputBorder.none,
                  ),
                ))
              : Container(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.4),
          (choosenLanguage != '')
              ? Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 12,
                        backgroundColor: PinkColors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: () async {
                        AddContact(nameController.text, numController.text,
                            emailController.text);
                      },
                      child: _loading == false
                          ? Text(languages[choosenLanguage]['Save Contact'],
                              style: const TextStyle(fontSize: 15))
                          : CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white))))
              : Container(),
        ],
      ),
    );
  }

  AddContact(
    String nameController,
    String numController,
    String emailController,
  ) async {
    setState(() {
      _loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final response = await http.post(
      Uri.parse(ApiConst.baseurl + "user_count"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$userId",
        "name": nameController,
        "phone": numController,
        "email": emailController,
      }),
    );
    var data = jsonDecode(response.body);
    print(data);
    print("aaaaaaaaaaaa");
    if (data['error'] == "200") {
      setState(() {
        _loading = false;
      });
      final phoneNo = data["data"]['phone'];
      print(phoneNo);
      print("kkkkkkkkkkkk");
      final prefs = await SharedPreferences.getInstance();
      final key = 'phone';
      final phone = phoneNo;
      prefs.setString(key, phone);
      Fluttertoast.showToast(
          msg: data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BottomNavigation(pageIndex: 1)));
      // print("Contact Add SuccessFully");
    } else {
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
