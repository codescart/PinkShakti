import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Screens/bottomnavigation.dart';

class ContactList extends StatefulWidget {
  ContactList({
    Key? key,
  }) : super(key: key);
  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: getPostApi,
      backgroundColor: Colors.white,
      color: Colors.redAccent,
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<List<Contact>>(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemExtent: 100,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // height: MediaQuery.of(context).size.height*0.4,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(width: 0.2, color: blackColor),
                            borderRadius: BorderRadius.circular(10),
                            color: PinkColors.withOpacity(0.70),
                          ),
                          child: ListView(
                            children: [
                              ListTile(
                                  leading: const CircleAvatar(
                                    backgroundColor: purple,
                                    child: Icon(
                                      Icons.person,
                                      color: whiteColor,
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      snapshot.data![index].name.toString(),
                                      style: const TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data![index].phone.toString(),
                                        style: const TextStyle(
                                            fontSize: 14, color: blackColor),
                                      ),
                                      Text(
                                        snapshot.data![index].email == null
                                            ? ""
                                            : snapshot.data![index].email
                                                .toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: blackColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: InkWell(
                                    onTap: () async {
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                          title: const Center(
                                            child: Text(
                                              'Alert',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          content: const Text(
                                            'Are you sure want to remove this contact?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      height: 40,
                                                      width: 120,
                                                      color: PinkColors,
                                                      child: const Center(
                                                        child: Text(
                                                          "Cancel",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final response =
                                                        await http.post(
                                                      Uri.parse(
                                                          ApiConst.baseurl +
                                                              'userdelete'),
                                                      headers: <String, String>{
                                                        'Content-Type':
                                                            'application/json; charset=UTF-8',
                                                      },
                                                      body: jsonEncode(<String,
                                                          String>{
                                                        "id": snapshot
                                                            .data![index].id
                                                            .toString(),
                                                      }),
                                                    );
                                                    print("Ajay");
                                                    print(snapshot
                                                        .data![index].id
                                                        .toString());
                                                    final data = jsonDecode(
                                                        response.body);
                                                    print(response.body);
                                                    if (data['error'] == 200) {
                                                      Fluttertoast.showToast(
                                                        msg:
                                                            "Contact Deleted Successfully",
                                                        toastLength:
                                                            Toast.LENGTH_SHORT,
                                                        gravity:
                                                            ToastGravity.CENTER,
                                                        timeInSecForIosWeb: 1,
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        fontSize: 16.0,
                                                      );
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  BottomNavigation(
                                                                      pageIndex:
                                                                          1)));
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Wait Something Went Wrong",
                                                          toastLength: Toast
                                                              .LENGTH_SHORT,
                                                          gravity: ToastGravity
                                                              .CENTER,
                                                          timeInSecForIosWeb: 1,
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          fontSize: 16.0);
                                                    }
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 120,
                                                    color: Colors.purple,
                                                    child: const Center(
                                                      child: Text(
                                                        "Confirm",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: PinkColors,
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: blackColor,
                                        )),
                                  ))
                            ],
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
            }),
      ),
    );
  }

  Future<List<Contact>> getPostApi() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'userId';
    final userId = prefs.getString(key) ?? 0;

    final resposne = await http.post(
      Uri.parse(ApiConst.baseurl + 'contact_get'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "user_id": "$userId",
      }),
    );
    var data = jsonDecode(resposne.body.toString())['data'];
    print("lucknow");
    List<Contact> postList = [];
    for (var o in data) {
      Contact al = Contact(
        o["id"],
        o["user_id"],
        o["name"],
        o["phone"],
        o["email"],
      );
      postList.add(al);
    }
    return postList;
  }
}

class Contact {
  String? id;
  String? user_id;
  String? name;
  String? phone;
  String? email;

  Contact(
    this.id,
    this.user_id,
    this.name,
    this.phone,
    this.email,
  );
}
