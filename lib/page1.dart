import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prototype3/advertiser.dart';
import 'package:prototype3/loginscreen.dart';
import 'package:prototype3/mainscreen.dart';
import 'package:toast/toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:place_picker/place_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

 
void main() => runApp(Page1());

File _image;
String pathAsset = 'assets/images/upload.jpg';
String urlUpload = "http://mobilehost2019.com/LBAS/php/upload_job.php";
String urlgetuser = "http://mobilehost2019.com/LBAS/php/get_user.php";

final TextEditingController _titlecontroller = TextEditingController();
final TextEditingController _desccontroller = TextEditingController();
final TextEditingController _radiuscontroller = TextEditingController();
final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
Position _currentPosition;
String _title, _description, _radius, _latitude, _longitude; 
double _sliderValue = 5;
String _currentAddress = "Searching your current location...";
// double _currentLatitude = 6.45751;
// double _currentLongitude = 100.505;
double _currentLatitude;
double _currentLongitude;

class Page1 extends StatefulWidget {
  final Advertiser advertiser;
  const Page1({Key key, this.advertiser}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  //Completer<GoogleMapController> _controller = Completer();
  List<Marker> allMarkers = [];
  Position position;
  GoogleMapController _controller;
  Widget  _child;

  static final CameraPosition _kGooglePlex = CameraPosition(
    //target: LatLng(6.45751, 100.505),
    target: LatLng(_currentLatitude, _currentLongitude),
    zoom: 17.0,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _sliderValue = 5.0;
    //_getCurrentLocation();
    print("This is latitude: $_currentLatitude");
    print("This is latitude: $_currentLongitude");
    //_child=RippleIndicator("Getting Location");
    _getCurrentLocation2();
    print("latitude: $position.latitude");
    print("latitude: $position.longitude");

    /*allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: false,
      onTap: (){
        print('add marker here');
      },
      position: LatLng(_currentLatitude, _currentLongitude)
      //position: LatLng(6.45751, 100.505)
    ));*/
    //addMarker();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        appBar: AppBar(
            title: Text('Advertise Advertisement'),
            backgroundColor: Colors.blueAccent,
          ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              GestureDetector(
                onTap: _choose,
                child: Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image:
                        _image == null ? AssetImage(pathAsset) : FileImage(_image),
                    fit: BoxFit.fill,
                  )),
                )
              ),
              SizedBox(height: 10.0),
              Text(_image == null
                ? 'Click on image above to take profile picture': '',
                style: new TextStyle(fontSize: 16.0)
              ),
              SizedBox(height: 10.0),
              Container(
                color: Color.fromRGBO(215, 248, 250, 1),
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Title : ',
                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _titlecontroller,
                      keyboardType: TextInputType.text,     
                    ),
                    SizedBox(height: 10.0),
                    Text('Description : ',
                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 2.0),
                    TextField(
                      controller: _desccontroller,
                      keyboardType: TextInputType.multiline,    
                      maxLines: 5, 
                      scrollPadding: EdgeInsets.all(20.0),
                      //autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          
                        )
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text('Radius : ',
                      style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 3.0),
                    Slider(
                      activeColor: Colors.indigoAccent,
                      min: 5.0,
                      max: 20.0,
                      onChanged: (newRating) {
                        setState(() => _sliderValue = newRating);
                      },
                      value: _sliderValue,
                    ),
                    Center(
                      child: Text(((_sliderValue)).round().toString() + ' KM',
                        style: TextStyle(fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 15.0,
                        ),
                        SizedBox(width: 2.0),
                        Text("Location ",
                          style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                        ),                 
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(_currentAddress,
                            style: TextStyle(fontSize: 16.0),
                          ),
                    ),
                    SizedBox(height: 10.0),
                    Center(
                      child: Container(
                          height: 160,
                          width: 340,
                          child: _child,
                          // child: GoogleMap(
                          //   mapType: MapType.normal,
                          //   initialCameraPosition: _kGooglePlex,
                          //   onMapCreated: (GoogleMapController controller) {
                          //   _controller.complete(controller);
                          //   },
                          //   markers: Set.from(allMarkers),
                          // ),
                        ),
                    ),
                      SizedBox(height: 20),
                      Center(
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                          minWidth: 300,
                          height: 50,
                          child: Text('Submit'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          elevation: 15,
                          onPressed: (){},
                        ),
                      ),
                  ],
                ),
              ),
            ]),
          ),
        ), 
      ),
      resizeToAvoidBottomPadding: true,
    ));
  }

  Future<bool> _onBackPressAppBar() async {
    _image=null;
    _titlecontroller.text='';
    _desccontroller.text='';
    _sliderValue = 0;
    _currentAddress = "Searching your current location...";
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(advertiser: advertiser),
        ));
    return Future.value(false);
  }

  void _choose() async {
    print('action gallery');
    File _galleryImage;
    _galleryImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (_galleryImage != null) {
      _image = _galleryImage;
      setState(() {});
    }
  }

  Future<void> addMarker() async{
    await _getCurrentLocation();
    allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: false,
      onTap: (){
        print('add marker here');
      },
      position: LatLng(_currentLatitude, _currentLongitude)
      //position: LatLng(6.45751, 100.505)
    ));
  }

  _getCurrentLocation2() async{
    Position res = await Geolocator().getCurrentPosition();
    setState((){
      position = res;
      _child = mapWidget();
    });
    _getAddressFromLatLng();
  }

  Widget mapWidget(){
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarker(),
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 13.0,
      ),
      onMapCreated: (GoogleMapController controller){
        _controller = controller;
      },
    );
  }

  Set<Marker> _createMarker(){
    return <Marker>[
      Marker(
        markerId: MarkerId("myLocation"),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: "$position"),
      )
    ].toSet();
  }


  _getCurrentLocation() async {
    geolocator
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
      .then((Position position) {
      setState(() {
        _currentPosition = position;
        _currentLatitude = double.parse((position.latitude).toString());
        _currentLongitude = double.parse((position.longitude).toString());
        print(_getCurrentLocation);
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.name},${place.locality}, ${place.postalCode}, ${place.country}";
            print(p[0]);
      });
    } catch (e) {
      print(e);
    }
  }
}
 