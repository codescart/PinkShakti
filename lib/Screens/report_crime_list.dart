import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Report_Crime_List extends StatefulWidget {
  const Report_Crime_List({Key? key}) : super(key: key);
  @override
  State<Report_Crime_List> createState() => _Report_Crime_ListState();
}
class _Report_Crime_ListState extends State<Report_Crime_List> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: Icon(Icons.arrow_back_ios)),
          title: (choosenLanguage != '') ?
          Text(languages[choosenLanguage]['View Report Crime']) : Container(),
          centerTitle: true,
          backgroundColor: PinkColors,
        ),
        body: FutureBuilder<List<CrimeView>>(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (snapshot.hasError)  print(snapshot.error);
              return snapshot.hasData
                  ?  ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10,
                        ),
                       ),
                      elevation: 12,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: blackColor
                          ),
                          borderRadius: BorderRadius.circular(
                              10
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (choosenLanguage != '') ? Container(
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // height: 60,
                                    width: MediaQuery.of(context).size.width/4,
                                    child:Text(languages[choosenLanguage]['Description'], style: TextStyle(overflow: TextOverflow.ellipsis ),),
                                  ),
                                 const SizedBox(
                                    width: 15,
                                  ),
                                 Container(
                                   width: MediaQuery.of(context).size.width/1.7,
                                   child:  Text(snapshot.data![index].description.toString()),
                                 )
                                ],
                              ),
                            ) : Container(),
                            SizedBox(height: 15,),
                              (choosenLanguage != '') ? Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child:Text(languages[choosenLanguage]['Incident Type']),
                                    ),
                                    SizedBox(width: 15,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.7,
                                      child:Text(snapshot.data![index].incident_type.toString())
                                    )
                                  ],
                                ),
                              ) : Container(),
                              SizedBox(height: 15,),
                              (choosenLanguage != '') ? Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child: Text(languages[choosenLanguage]['Address']),
                                    ),
                                    const SizedBox(width: 15,),
                                    Container(
                                        width: MediaQuery.of(context).size.width/1.7,
                                        child: Text(snapshot.data![index].address.toString())
                                    ),
                                  ],
                                ),
                              ) : Container(),
                              SizedBox(height: 15,),
                              (choosenLanguage != '') ? Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child:Text(languages[choosenLanguage]['City']),
                                    ),
                                   const SizedBox(width: 15,),
                                         Container(
                                         width: MediaQuery.of(context).size.width/1.7,
                                         child:Text(snapshot.data![index].city.toString())
                                    ),
                                  ],
                                ),
                              ) : Container(),
                              SizedBox(height: 15,),
                              (choosenLanguage != '') ? Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   Container(
                                      width: MediaQuery.of(context).size.width/4,
                                      child:Text(languages[choosenLanguage]['State']),
                                   ),
                                    SizedBox(width: 15,),
                                    Container(
                                        width: MediaQuery.of(context).size.width/1.7,
                                        child:Text(snapshot.data![index].state.toString()),
                                    ),
                                  ],
                                ),
                              ) : Container(),
                          ],
                        ),
                      ),
                    );
                  },
                ):const Center(
                child: CircularProgressIndicator(),
              );
            }
        )
    );
  }

  Future<List<CrimeView>> getPostApi() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;
    final resposne = await http.post(
        Uri.parse(ApiConst.baseurl + 'report_crime_get'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "user_id": "$userId",
        })
    );
    var data = jsonDecode(resposne.body.toString())['data'];
    List<CrimeView> postList = [];
    for (var o in data)  {
      CrimeView al = CrimeView(
          o["id"],
          o["description"],
          o["incident_type"],
          o["address"],
          o["state"],
          o["city"],
          o["userId"]
      );
      postList.add(al);
    }
      return postList;
    }
  }
class CrimeView {
  String? id;
  String? description;
  String? incident_type;
  String? address;
  String? state;
  String? city;
  String? userId;

  CrimeView(
    this.id,
    this.description,
    this.incident_type,
    this.address,
    this.state,
    this.city,
    this.userId
  );
}