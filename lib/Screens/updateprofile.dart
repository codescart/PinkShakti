import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinkPower/Screens/profilescreen.dart';
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
   String? image;
   String? name;
   String? email;
   String? phone;
   String? age;
   String? address;

  EditProfile({this.image,  this.name,  this.email,  this.phone,  this.age,  this.address,});

  @override
  _EditProfileState createState() => _EditProfileState();
}
class _EditProfileState extends State<EditProfile> with SingleTickerProviderStateMixin {

  bool isLogin = true;
  late Animation<double> containerSize;
  AnimationController? animationController;
  Duration animationDuration = Duration(milliseconds: 270);
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController address=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultRegisterSize = size.height - (size.height * 0.1);
    containerSize = Tween<double>(begin: size.height * 0.1, end: defaultRegisterSize).animate(CurvedAnimation(parent: animationController!, curve: Curves.linear));
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
                    borderRadius: BorderRadius.circular(50),
                    color: purple
                ),
              )
          ),
          Positioned(
              top: -50,
              left: -50,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: PinkColors
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
          Align(
            alignment: Alignment.center,
            child:  Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    SizedBox(
                      height: 115,
                      width: 115,
                      child: Stack(
                        children: [
                          file == null?
                          CircleAvatar(
                              radius: 70,
                              backgroundColor:  faceColor,
                              backgroundImage: NetworkImage("https://ladli.wishufashion.com/api/uploads/"+widget.image.toString())
                          ):CircleAvatar(radius: 70, backgroundImage: FileImage(file!,),),
                          Positioned(
                              right: 0,
                              bottom:0,
                              child: Container(
                                height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: PinkColors,
                                      shape: BoxShape.circle
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      _choose();
                                    },
                                    icon: const Icon(Icons.camera_alt,size: 20,color: whiteColor,),
                                  ),
                              ),
                          ),
                        ],
                      ),

                    ),
                    SizedBox(height: 30,),
                    (choosenLanguage != '') ?  InputContainer(
                        child: TextField(
                          controller: name..text=widget.name!,
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
                          maxLines: 2,
                          controller: email..text=widget.email!,
                          cursorColor: PinkColors,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.mail, color: PinkColors),
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
                          controller:  phone..text=widget.phone!,
                          cursorColor: PinkColors,
                          decoration: InputDecoration(
                              counterText: '',
                            icon: const Icon(Icons.phone_android_rounded, color: PinkColors
                            ),
                            hintText: languages[choosenLanguage]['Mobile Number'],hintStyle: GoogleFonts.roboto(),
                            border: InputBorder.none,
                          ),
                        )
                    ):Container(),
                    const SizedBox(height: 5),
                    (choosenLanguage != '') ?  InputContainer(
                        child: TextField(
                          controller: age..text=widget.age!,
                          maxLength: 2,
                          cursorColor: PinkColors,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            icon: const Icon(
                                Icons.apps_outage_rounded, color: PinkColors
                            ),
                            hintText: languages[choosenLanguage]['Age'], hintStyle: GoogleFonts.roboto(),
                            border: InputBorder.none,
                          ),
                        )
                    ):Container(),
                    const SizedBox(height: 5),
                    (choosenLanguage != '') ?  InputContainer(
                        child: TextField(
                          controller: address..text=widget.address!,
                          cursorColor: PinkColors,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.location_on, color: PinkColors
                            ),
                            hintText: languages[choosenLanguage]['Address'],hintStyle: GoogleFonts.roboto(),
                            border: InputBorder.none,
                          ),
                        )
                    ):Container(),
                    // RoundedPasswordInput(hint: 'Password'),
                    const SizedBox(height: 20),
                    (choosenLanguage != '') ?
                    Container(
                        width:  MediaQuery.of(context).size.width * 0.80,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 12,
                              backgroundColor: PinkColors,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20.0
                                ),
                              ),
                            ),
                            onPressed: (){
                              setState(() async {
                                profileupdate(name.text,email.text,phone.text,age.text,address.text);
                              });
                             }, child: setUpButtonChild())
                        ):Container(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  var mydata;
  File? file;
  final picker = ImagePicker();
  void _choose() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 50, maxHeight: 500, maxWidth: 500);
    setState(() {
      if (pickedFile != null) {
        file = File(pickedFile.path);
        final bytes = File(pickedFile.path).readAsBytesSync();
        String img64 = base64Encode(bytes);
        mydata = img64;
        print('Abhinav');
        print(img64);
        print('Thi');
      } else {
        print('No image selected.');
      }
    });
  }
 bool _loading=false;
  profileupdate(String name, String email, String phone, String age, String address,) async {
    print(name);
    print(email);
    print(phone);
    print(age);
    print(address);
    print(mydata);
    print("object");
    setState(() {
      _loading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? "0";
    print('ggggggggggggg');
    final response = await http.post(
      Uri.parse("https://ladli.wishufashion.com/api/update_user.php"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id": userId,
        "name": name,
        "email": email,
        "mobile": phone,
        "age": age,
        "address": address,
        "image": mydata
      }),
    );
    print('bbbbb');
    final data = jsonDecode(response.body);
    print(data);
    print('ssssss');
    if (data["success"] == "200") {
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: purple,
          textColor: Colors.white,
          fontSize: 10.0);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
    } else {
      setState(() {
        _loading = false;
      });
      Fluttertoast.showToast(
          msg: data["msg"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: PinkColors,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

  Widget setUpButtonChild() {
    if (_loading==false) {
      return  Text((choosenLanguage != '')?languages[choosenLanguage]['Update']:"",
          style: TextStyle(fontSize: 25)
      );
    } else {
      return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
    }
  }
}
