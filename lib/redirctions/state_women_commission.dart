import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:pinkPower/Constant/api.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Language/function.dart';
import 'package:pinkPower/Language/translation.dart';
import 'package:http/http.dart' as http;

class State_Women_Commi extends StatefulWidget {
  @override
  _State_Women_CommiState createState() => _State_Women_CommiState();
}

class _State_Women_CommiState extends State<State_Women_Commi> with SingleTickerProviderStateMixin {

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: PinkColors,
        shadowColor: Colors.transparent,
        title: (choosenLanguage != '') ?Text(languages[choosenLanguage]['official&contacts'], style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),):Container(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,size: 18,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body:FutureBuilder<List<Contact>>(
        future: getPostApi(),
        builder: (context, snapshot){
          if (snapshot.hasError)  print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index){
                return Padding(
                    padding: EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration:  BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [new BoxShadow(
                          color: Color(0xffffc2d2),
                          blurRadius: 20.0,
                        ),]
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('Name : '),
                            Text('${snapshot.data![index].name}'),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('Designation : '),
                            Text('${snapshot.data![index].designation}'),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Phone : '),
                            TextButton(onPressed: (){
                              FlutterPhoneDirectCaller.callNumber('${snapshot.data![index].phone_1}');
                            }, child: Text('${snapshot.data![index].phone_1}')),
                            snapshot.data![index].phone_2==null?Text(""):TextButton(onPressed: (){
                              FlutterPhoneDirectCaller.callNumber('${snapshot.data![index].phone_2}');
                            }, child: Text('${snapshot.data![index].phone_2}'))
                          ],
                        ),
                        Row(
                          children: [
                            Text('Email : '),
                            snapshot.data![index].email==null?Text("Email Not Avalable"):Text('${snapshot.data![index].email}'),
                          ],
                        )
                      ],
                    ),
                  )
                );
              }):const Center(
               child: CircularProgressIndicator(color: PinkColors,),
          );
        },
      ),
    );
  }
  Future<List<Contact>> getPostApi() async {
    final resposne = await http.get(
      Uri.parse( ApiConst.baseurl + 'all_data'),
    );
    var data = jsonDecode(resposne.body.toString())['country'];
    List<Contact> postList = [];
    for (var o in data)  {
      Contact al = Contact(
        o["id"],
        o["name"],
        o["designation"],
        o["phone_1"],
        o["phone_2"],
        o["email"],
        o["status"],
      );
      postList.add(al);
    }
    return postList;
  }
}

class Contact {
  String? id;
  String? name;
  String? designation;
  String? phone_1;
  String? phone_2;
  String? email;
  String? status;
  Contact(
      this.id,
      this.name,
      this.designation,
      this.phone_1,
      this.phone_2,
      this.email,
      this.status,
      );
}
