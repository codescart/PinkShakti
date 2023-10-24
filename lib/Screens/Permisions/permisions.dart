import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:pinkPower/Screens/bottomnavigation.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    final width =MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Permission",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white),
        ),
        backgroundColor: kBackgroundColor,
        leading: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Container(
          width: width,
          child: ElevatedButton(
            onPressed: () async {
              Map<Permission, PermissionStatus> statuses = await [
                Permission.location,
                Permission.contacts,
              ].request();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => BottomNavigation(pageIndex: 0,)));
            },
            style: ElevatedButton.styleFrom(
              primary: Color(0xFFF9A825),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 15.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'PROCEED',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.white),
              ),
            ),
          ),
        ),
      ),
      body: Column(children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'By clicking on "proceed",you will be promted to grant the following permissions.',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        // Row(
        //   children: [
        //     Padding(padding: const EdgeInsets.all(2.0)),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     Icon(
        //       Icons.sms_rounded,
        //       color: Colors.orange,
        //     ),
        //     SizedBox(
        //       width: 10,
        //     ),
        //     Text(
        //       "SMS",
        //       textAlign: TextAlign.right,
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontSize: 15,
        //           fontWeight: FontWeight.bold),
        //     ),
        //   ],
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(left: 40, right: 5),
        //   child: Text(
        //     "Pink Shakti asked for the sms permision becaus it sends sms along with your location and other data to the contacts that mentioned by you in the app in case of any emergency.",
        //     style: TextStyle(
        //       color: Colors.black,
        //     ),
        //   ),
        // ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Padding(padding: const EdgeInsets.all(2.0)),
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.location_on,
              color: Colors.orange,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Location",
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 5),
          child: Text(
            'Pink Shakti app collects your location data for the purpose of providing you a hospital and police service directly from the help center in case of any emergency.',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Padding(padding: const EdgeInsets.all(2.0)),
            SizedBox(
              height: 10,
            ),
            Icon(
              Icons.contacts,
              color: Colors.orange,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Contact",
              textAlign: TextAlign.right,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 5),
          child: Text(
            'We need this to help you find your contacts easily while sending SMS.',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ]),
    );
  }
}