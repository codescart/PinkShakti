import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pinkPower/Model/police.dart';
import 'package:pinkPower/Model/toilet.dart';
import 'package:pinkPower/Constant/color.dart';
import 'package:http/http.dart' as http;
import 'package:pinkPower/Model/hospital.dart';
import 'package:pinkPower/dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeMapPage extends StatefulWidget {
  const HomeMapPage({Key? key}) : super(key: key);
  @override
  _HomeMapPageState createState() => _HomeMapPageState();
}
class _HomeMapPageState extends State<HomeMapPage> {
  var lat="0.000";
  var long="0.000";
  var latt;
  var longg;
  var pj;
  String apiKey = "AIzaSyANhzkw-SjvdzDvyPsUBDFmvEHfI9b8QqA";
  String radius = "30";

  double latitude = 31.5111093;
  double longitude = 74.279664;

  NearbyPlacesResponse nearbyPlacesResponse = NearbyPlacesResponse();

  Toilet toiletnearbyPlacesResponse = Toilet();

  Police policenearbyPlacesResponse = Police();

  Completer<GoogleMapController>  _controller = Completer();
  String _draggedAddress = "";
  CameraPosition? _cameraPosition;
  late LatLng _defaultLatLng;
  late LatLng _draggedLatlng;
  _init() {
    _defaultLatLng = const LatLng(20.5937, 78.9629);
    _draggedLatlng = _defaultLatLng;
    _cameraPosition = CameraPosition(
        target: _defaultLatLng,
        zoom: 10.5
    );
    _gotoUserCurrentPosition();
  }
  Uint8List? marketimages;
  final List<Marker> _markers =[];
  Future<Uint8List> getImages(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer
        .asUint8List();
  }
  @override
  void initState() {
    _init();
    _fluttermassoge();
    super.initState();
  }

  _fluttermassoge(){
    Fluttertoast.showToast(
        msg: 'Click on Pin and scroll Map',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: purple,
        textColor: Colors.white,
        fontSize: 16.0);
  }
  Future<Uint8List?>loadNetWorkImage(String path) async{
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info,_) =>completer.complete(info))
    );
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }



  void getNearbyPolice() async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=police&location=$lat,$long&radius=15000&type=police%20&key=$apiKey');
    var response = await http.post(url);
    policenearbyPlacesResponse = Police.fromJson(jsonDecode(response.body));
    for(int i = 0 ; i < policenearbyPlacesResponse.results!.length; i++) {
      var lats = double.parse(
          policenearbyPlacesResponse.results![i].geometry!.location!.lat.toString());
      var longs = double.parse(policenearbyPlacesResponse.results![i].geometry!.location!.lng.toString());
      final Uint8List markIcons = await getImages('assets/images/policei.png', 80);
      var plaid=policenearbyPlacesResponse.results![i].placeId.toString();
      final res= await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=$plaid&key=$apiKey'));
      final dasa= jsonDecode(res.body)['result'];
      setState(() {
        final phone= dasa['formatted_phone_number'];
        _markers.add(
            Marker(
                markerId: MarkerId(policenearbyPlacesResponse.results![i].placeId.toString()),
                icon: BitmapDescriptor.fromBytes(markIcons),
                position: LatLng(lats, longs),
                infoWindow: InfoWindow(
                    title: policenearbyPlacesResponse.results![i].name,
                    snippet: policenearbyPlacesResponse.results![i].vicinity,
                    onTap: () {
                      var ph='';
                      setState(() {
                        ph=phone;
                        // print(ph);
                        // print("aaaaaaaaaa");
                      });
                      ph==null?showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Center(child: Text("Number Not Available",style: TextStyle(fontSize: 16),)),
                          )
                      ):FlutterPhoneDirectCaller.callNumber(ph);
                    })
            )
        );
      });
    }
  }



  void getNearbyHospital() async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=hospital&location=$lat,$long&radius=15000&type=hospital%20&key=$apiKey');
    var response = await http.post(url);
    nearbyPlacesResponse = NearbyPlacesResponse.fromJson(jsonDecode(response.body));
    print(response);
    print("vvvvvvvvvvvvvv");
    for(int i = 0 ; i < nearbyPlacesResponse.results!.length; i++) {
        var lats = double.parse(
            nearbyPlacesResponse.results![i].geometry!.location!.lat.toString());
        var longs = double.parse(nearbyPlacesResponse.results![i].geometry!.location!.lng.toString());
        final Uint8List markIcons = await getImages('assets/images/hospicon.png', 80);
        var plaid=nearbyPlacesResponse.results![i].placeId.toString();
        final res= await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=$plaid&key=$apiKey'));
        final dasa= jsonDecode(res.body)['result'];
        setState(() {
         final phone= dasa['formatted_phone_number'];
          _markers.add(
              Marker(
                  markerId: MarkerId(nearbyPlacesResponse.results![i].placeId.toString()),
                  icon: BitmapDescriptor.fromBytes(markIcons),
                  position: LatLng(lats, longs),
                  infoWindow: InfoWindow(
                      title: nearbyPlacesResponse.results![i].name,
                      snippet: nearbyPlacesResponse.results![i].vicinity,
                      onTap: () {
                        var ph='';
                        setState(() {
                          ph=phone;
                          print(ph);
                          print("aaaaaaaaaa");
                        });
                        ph==null?showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Center(child: Text("Number Not Available",style: TextStyle(fontSize: 16),)),
                            )
                        ):FlutterPhoneDirectCaller.callNumber(ph);
                      })
              )
          );
        });

      }
  }





  void getNearbyTolet() async {
    var url = Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=toilet&location=$lat,$long&radius=15000&type=toilet%20&key=$apiKey');
    var response = await http.post(url);
    toiletnearbyPlacesResponse = Toilet.fromJson(jsonDecode(response.body));
    for(int i = 0 ; i < toiletnearbyPlacesResponse.results!.length; i++) {
      var lats = double.parse(
          toiletnearbyPlacesResponse.results![i].geometry!.location!.lat.toString());
      var longs = double.parse(toiletnearbyPlacesResponse.results![i].geometry!.location!.lng.toString());
      final Uint8List markIcons = await getImages('assets/images/ladies.png', 80);
      var plaid=toiletnearbyPlacesResponse.results![i].placeId.toString();
      final res= await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_phone_number&place_id=$plaid&key=$apiKey'));
      final dasa= jsonDecode(res.body)['result'];
      setState(() {
        final phone= dasa['formatted_phone_number'];
        _markers.add(
            Marker(
                markerId: MarkerId(toiletnearbyPlacesResponse.results![i].placeId.toString()),
                icon: BitmapDescriptor.fromBytes(markIcons),
                position: LatLng(lats, longs),
                infoWindow: InfoWindow(
                    title: toiletnearbyPlacesResponse.results![i].name,
                    snippet: nearbyPlacesResponse.results![i].vicinity,
                    onTap: () {
                      var ph='';
                      setState(() {
                         ph=phone;
                        // print(ph);
                        // print("aaaaaaaaaa");
                      });
                      ph==null?showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: Center(child: Text("Number Not Available",style: TextStyle(fontSize: 16),)),
                          )
                      ):FlutterPhoneDirectCaller.callNumber(ph);
                    })
            )
        );
      }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.85,
              child: _buildBody(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: whiteColor,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28,
                      vertical: 8,
                  ),
                  child: Row(
                    children: [
                     Icon(
                        Icons.location_on,
                        size: 22,
                        color:Theme.of(context).primaryColor,
                      ),
                   const SizedBox(
                        width: 10,
                      ),
                  Flexible(
                    child: Text(
                           _draggedAddress,
                           style: Theme.of(context)
                               .textTheme
                               .bodyText1!
                               .copyWith(
                               fontWeight: FontWeight.normal
                           ),
                           maxLines: 2,
                         ),
                       ),
                   ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBody() {
    return Stack(
        children : [
           _getMap(),
          _getCustomPin(),
          _getCustomDrawer(),
          _getLoctionButton()
        ]
    );
  }

  Widget _getMap() {
    return GoogleMap(
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      zoomGesturesEnabled: true,
        myLocationButtonEnabled: false,
      markers: Set<Marker>.of(_markers),
      initialCameraPosition: _cameraPosition!,
      mapType: MapType.normal,
      onCameraIdle: () {
        _getAddress(_draggedLatlng);
      },
      onCameraMove: (cameraPosition) {
        _draggedLatlng = cameraPosition.target;
      },
      onMapCreated: (GoogleMapController controller) {
        if (!_controller.isCompleted) {
          _controller.complete(controller);
        }
      }
    );
  }

  Future _gotoUserCurrentPosition() async {

    final prefs = await SharedPreferences.getInstance();
    final key = 'userName';
    final userName = prefs.getString(key) ?? 0;

    Position currentPosition = await _determineUserCurrentPosition();
    _gotoSpecificPosition(
        LatLng(currentPosition.latitude, currentPosition.longitude));
    final Uint8List locationIcon = await getImages('assets/images/curenticon.png', 70);
    setState(() async {


      lat = currentPosition.latitude.toString();
      long = currentPosition.longitude.toString();



      var lats = double.parse(lat);
      var longs = double.parse(long);

      getNearbyTolet();
      getNearbyPolice();
      getNearbyHospital();

      _markers.add(
          Marker(
              markerId: MarkerId('0'),
              icon: BitmapDescriptor.fromBytes(locationIcon),
              position: LatLng(lats, longs),
              infoWindow: InfoWindow(
                  title: "$userName",
                  )
          )
      );
    });

  }

  Future _gotoSpecificPosition(LatLng position) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(
        CameraPosition(
            target: position,
            zoom: 13.5
        )
    )
    );
    await _getAddress(position);
  }

  Future _getAddress(LatLng position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark address = placemarks[0];
    String addresStr = "${address.street}, ${address.locality}, ${address
        .administrativeArea}, ${address.country}";
    setState(() {
      latt = position.latitude;
      longg = position.longitude;
      _draggedAddress = addresStr;
    });
    SharedPreferences newadd = await SharedPreferences.getInstance();
    newadd.setString('Adress', addresStr);
  }

  Future _determineUserCurrentPosition() async {
    LocationPermission locationPermission;
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    //check if user enable service for location permission
    if (!isLocationServiceEnabled) {
     print("user don't enable location permission");
    }
    locationPermission = await Geolocator.checkPermission();
    if(locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if(locationPermission == LocationPermission.denied) {
        print("user denied location permission");
      }
    }

    if(locationPermission == LocationPermission.deniedForever) {
      print("user denied permission forever");
    }
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }

    Widget _getCustomPin() {
      return Positioned(
        top: 100,
        left: 150,
      child: InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: Text(_draggedAddress,),
                content: Container(
                    height: 200,
                    width: 400,
                    child:Alerts(
                        lats:latt.toString(),
                        longs:longg.toString(),
                        address:_draggedAddress
                    )
                )
            ),
          );

        },
        child: Container(
          width: 50,
          height: 50,
          child: Image.asset("assets/mpin.png"),
        ),
      ),
    );
  }

    Widget _getCustomDrawer() {
    return Positioned(
      top: 40,
      left: 20,
      child: InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [new BoxShadow(
                color: Colors.black38,
                blurRadius: 20.0,
              ),]
          ),
          child: Icon(Icons.menu),
        ),
      ),
    );
  }

  Widget _getLoctionButton() {
    return Positioned(
      bottom: 100,
      right: 20,
      child: InkWell(
        onTap:  (){
          _gotoUserCurrentPosition();
        },
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [new BoxShadow(
                color: Colors.black38,
                blurRadius: 20.0,
              ),]
          ),
          child: Icon(Icons.my_location),
        ),
      ),
    );
  }
}









