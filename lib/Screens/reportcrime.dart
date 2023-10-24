import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:pinkPower/Screens/report_crime_list.dart';
import 'package:pinkPower/components/input_container.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportCrime extends StatefulWidget {
  const ReportCrime({Key? key}) : super(key: key);
  @override
  State<ReportCrime> createState() => _ReportCrimeState();
}
class _ReportCrimeState extends State<ReportCrime> {
  var dropdownvalue;
  List items =  [];


  Future getAllCategory() async {
    print('pankaj');
    var baseUrl = "https://ladli.wishufashion.com/api/Mobile_app/alldata_n";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)["country"];
      print("aaaaaaaaaa");
      print(jsonData);
      setState(() {
        items = jsonData;
      });
    }
  }

  TextEditingController description =TextEditingController();
  TextEditingController  address =TextEditingController();
  TextEditingController  city =TextEditingController();
  // TextEditingController  state =TextEditingController();
  @override
  void initState() {
    getAllCategory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,size: 18,)),
        title: (choosenLanguage != '') ?
        Text( languages[choosenLanguage]['Report Share Crime']):Container(),
        centerTitle: true,
        backgroundColor: PinkColors,
      ),
      body: SingleChildScrollView(
        child:  Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              // SizedBox(height: 10,),
              (choosenLanguage != '') ?Container(
                width:   MediaQuery.of(context).size.width*0.8,
                height: 50,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: PinkColors.withAlpha(70)
                ),
                child: Center(
                  child: Text(
                      languages[choosenLanguage]['sharecrimemanually'],
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color:Colors.black)
                  ),
                ),
              ):Container(),
              SizedBox(height: 10,),
              Center(
              child: Container(
              height: 100,
                width:  MediaQuery.of(context).size.width*0.93,
              margin: EdgeInsets.only(top: 10),
              child: InputContainer(
              child: TextField(
                controller: description,
              maxLines: 5,
                cursorColor: PinkColors,
                decoration: InputDecoration(
                  hintText: languages[choosenLanguage]['Description'],hintStyle: GoogleFonts.roboto(),
                  border: InputBorder.none,
                ),
           ),
          ),
          ),
         ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 12,
                child: Container(
                  height: 50,
                  width:  MediaQuery.of(context).size.width*0.93,
                  padding: EdgeInsets.only(left: 20, right:15, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: PinkColors.withAlpha(50)
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        languages[choosenLanguage]['ChooseCrime'],
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme
                              .of(context)
                              .hintColor,
                        ),
                      ),
                      items: items
                          .map((item) =>
                          DropdownMenuItem<String>(
                            value:  item['name'].toString(),
                            child: Text(
                              item['name'].toString(),
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                          .toList(),
                      value: dropdownvalue,
                      onChanged: (newVal) {
                        setState(() {
                          dropdownvalue = newVal;
                          print(dropdownvalue);
                        });
                      },
                    ),
                  ),
                ),
              ),
              (choosenLanguage != '') ?  Container(
                width:  MediaQuery.of(context).size.width*0.95,
                child: InputContainer(
                    child: TextField(
                      controller: address,
                      cursorColor: PinkColors,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.location_on, color: PinkColors
                        ),
                        hintText: languages[choosenLanguage]['Address'],hintStyle: GoogleFonts.roboto(),
                        border: InputBorder.none,
                      ),
                    )
                ),
              ):Container(),
              (choosenLanguage != '') ?  Container(
                width:  MediaQuery.of(context).size.width*0.95,
                child: InputContainer(
                    child: TextField(
                      controller:  city,
                      // readOnly:  true,
                      cursorColor: PinkColors,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.location_city, color: PinkColors
                        ),
                        hintText:languages[choosenLanguage]['City'],hintStyle: GoogleFonts.roboto(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    )
                ),
              ):Container(),
              (choosenLanguage != '') ?  Container(
                width:  MediaQuery.of(context).size.width*0.95,
                child: InputContainer(
                    child: TextField(
                      readOnly:  true,
                      // controller: state,
                      cursorColor: PinkColors,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.real_estate_agent_sharp, color: PinkColors
                        ),
                        hintText:languages[choosenLanguage]['Uttar Pradesh'],hintStyle: GoogleFonts.roboto(color: Colors.black),
                        border: InputBorder.none,
                      ),
                    )
                ),
              ):Container(),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (choosenLanguage != '') ? Card(
                      color: Colors.transparent,
                      elevation:50,
                      child: InkWell(
                        onTap: (){
                          CrimeReport(description.text,address.text,city.text);
                        },
                        child: Container(
                            width:  MediaQuery.of(context).size.width*0.45,
                            height: 50,
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: PinkColors.withAlpha(70)
                            ),
                            child: Center(
                              child: Text(languages[choosenLanguage]['ShareCrime'],
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800)
                              ),
                            )
                        ),
                      ),
                    ):Container(),
                    (choosenLanguage != '') ? Card(
                      color: Colors.transparent,
                      elevation:50,
                      child: InkWell(
                        onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Report_Crime_List()));
                      },
                        child: Container(
                            width:   MediaQuery.of(context).size.width*0.45,
                            height: 50,
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: PinkColors.withAlpha(70)
                            ),
                            child: Center(
                              child: Text(languages[choosenLanguage]['View Report Crime'],
                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.w800)
                              ),
                            )
                        ),
                      ),
                    ):Container(),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              (choosenLanguage != '') ? Container(
                  width:   MediaQuery.of(context).size.width*0.8,
                  height: 50,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 12,
                        backgroundColor: PinkColors,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                      },
                      child: Text(languages[choosenLanguage]['CRIMEONMAP'],
                          style: TextStyle(fontSize: 15)
                      )
                  )
              ):Container(),
              // SizedBox(height: 10,),
              (choosenLanguage != '') ? Container(
                  width:   MediaQuery.of(context).size.width*0.8,
                  height: 50,
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 12,
                        backgroundColor: purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      onPressed: (){
                        _reportcrime();
                      },
                      child: Text(languages[choosenLanguage]['Report Crime'],
                          style: TextStyle(fontSize: 15)
                      )
                  )
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }

  CrimeReport(String description,String address, String city ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    print(userId);
    print(description);
    print(address);
    print(city);
    print(dropdownvalue);
    print("zzzzz");
    final response = await http.post(
      Uri.parse(ApiConst.baseurl+"report_crime"),
      headers: <String, String>{
        'Content-Type':'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id":"$userId",
        "description":description,
        "address":address,
        "city":city,
        "type":dropdownvalue
      }),
    );
    final data = jsonDecode(response.body);
    print(data);
    if (data['error'] == "200"){
      Fluttertoast.showToast(
          msg: "Report Crime SuccessFully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Report_Crime_List()));
          // print("Report crime  SuccessFully");
    } else {
      Fluttertoast.showToast(
          msg: "Check All Fields",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  _reportcrime() async {
    // print('zzzzzzzzzzzz');
    const url = 'https://uppolice.gov.in';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}