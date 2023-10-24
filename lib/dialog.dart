import 'dart:convert';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Alerts extends StatefulWidget {
 final String lats;
 final String longs;
 final String address;

 Alerts({Key? key, required this.lats, required this.longs, required this.address,}) : super(key: key);


  @override
  State<Alerts> createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {


  @override
  void initState() {
    getAllCategory();
    super.initState();
  }


  List categoryItemlist = [];

  Future getAllCategory() async {
    print('pankaj');
    var baseUrl = "https://ladli.wishufashion.com/api/Mobile_app/alldata_n";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body)["country"];
      print(jsonData);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  var dropdownvalue;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView(
        children: [
          Container(
            height: 55,
            width:MediaQuery.of(context).size.width*0.4,
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: faceColor,
            ),
            child: DropdownButtonHideUnderline(
              child:DropdownButton(
                hint: Text(
                  (choosenLanguage != '')?languages[choosenLanguage]['ChooseCrime']:"",
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme
                        .of(context)
                        .hintColor,
                  ),
                ),
                items: categoryItemlist
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
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child:
              Container(
                width: 110,
                height: 50,
                alignment : Alignment.center,
                color: Colors.pink,
                padding: const EdgeInsets.all(14),
                child: Text(
                  (choosenLanguage != '')?languages[choosenLanguage]['cancle']:"",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              InkWell(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (ctx) =>
                          AlertDialog(
                              title:   Text(widget.address),
                              content: Text((choosenLanguage != '')?languages[choosenLanguage]['AreYousure']:""),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                        onTap:(){
                                          Navigator.pop(context);
                                        },
                                        child:Container(
                                          alignment : Alignment.center,
                                          color: Colors.pink,
                                          padding: const EdgeInsets.all(14),
                                          child: Text(
                                            (choosenLanguage != '')?languages[choosenLanguage]['cancle']:"",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                    ),
                                    InkWell(
                                        onTap:(){
                                          MMMapCrime();
                                        },
                                        child:Container(
                                          alignment : Alignment.center,
                                          color: Colors.pink,
                                          padding: const EdgeInsets.all(14),
                                          child: Text(
                                            (choosenLanguage != '')?languages[choosenLanguage]['share']:"",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                    ),


                                  ],),
                              ]
                          ));
                },

                  child: Container(
                    width: 110,
                    height: 50,
                    color: Colors.purple,
                    padding: const EdgeInsets.all(
                        14
                    ),
                    child: Text((choosenLanguage != '')?languages[choosenLanguage]['ShareCrime']:"",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),



              )
            ],
          )
        ],
      ),
    )

      ;
  }
  MMMapCrime() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final device_id = prefs.getString(key) ?? 0;
    final address = prefs.getString(key) ?? 0;
    final phone = prefs.getString(key) ?? 0;
    final email = prefs.getString(key) ?? 0;

    final response = await http.post(
      Uri.parse(ApiConst.baseurl+"double"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id":"$userId",
        "device_id":'$device_id',
        "address":"$address",
        "phone":"$phone",
        "email":"$email",
        "latitude":widget.lats,
        "longitude":widget.longs,
        "place_name":widget.address,
        "crime": dropdownvalue!,
      }),
    );
    final data = jsonDecode(response.body);
    if (data['error'] == "200") {
      Fluttertoast.showToast(
          msg: "CRIME SHARED",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: PinkColors,
          textColor: Colors.white,
          fontSize: 16.0);
      reportmail(widget.address,widget.lats,widget.longs);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
    } else {
      Fluttertoast.showToast(
          msg: "NOT Crime Reported",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: purple,
          textColor: Colors.white,
          fontSize: 16.0);
      // print("hii");
    }
  }

  reportmail(String draggedAddress, String lat, String long)async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;

    final resposne = await http.post(
      Uri.parse( ApiConst.baseurl + 'contact_get'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$userId",
      }),
    );

    var data = jsonDecode(resposne.body)['data'];
    print(data);
    final prefs4 = await SharedPreferences.getInstance();
    final namees = prefs4.getString('userName') ?? 0;

    await http.get(Uri.parse(
        "https://ladli.foundercodes.com/api/stampingmail.php?name=$namees&lat=$lat&user_id=$userId&long=$long&crimetype=$dropdownvalue"
    ));
    if(data[0]['phone']!=null){
      print(data[0]['phone'].toString());
      await BackgroundSms.sendMessage(
        phoneNumber: data[0]['phone'].toString(), message:"Pink Shakti- \nUser -  $namees , has shared crime $dropdownvalue at this location https://maps.google.com/?q=$lat,$long",
      );

      if(data[1]['phone']!=null){
        await BackgroundSms.sendMessage(
          phoneNumber: data[1]['phone'].toString(), message:"Pink Shakti- \nUser -  $namees , has shared crime $dropdownvalue at this location https://maps.google.com/?q=$lat,$long",
        );
        if(data[2]['phone']!=null){
          await BackgroundSms.sendMessage(
            phoneNumber: data[2]['phone'].toString(), message:"Pink Shakti- \nUser -  $namees , has shared crime $dropdownvalue at this location https://maps.google.com/?q=$lat,$long",
          );
          if(data[3]['phone']!=null){
            await BackgroundSms.sendMessage(
              phoneNumber: data[3]['phone'].toString(), message:"Pink Shakti- \nUser -  $namees , has shared crime $dropdownvalue at this location https://maps.google.com/?q=$lat,$long",
            );
            if(data[4]['phone']!=null){
              await BackgroundSms.sendMessage(
                phoneNumber: data[4]['phone'].toString(), message:"Pink Shakti- \nUser -  $namees , has shared crime $dropdownvalue at this location https://maps.google.com/?q=$lat,$long",
              );

            }else{

            }
          }else{}
        }else{}
      }else{}
    }else{
      debugPrint('please add mobile');
    }
  }
}

