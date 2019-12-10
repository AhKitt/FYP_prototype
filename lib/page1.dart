import 'package:flutter/material.dart';
import 'package:prototype3/advertiser.dart';
import 'package:prototype3/loginscreen.dart';
import 'package:prototype3/mainscreen.dart';
 
void main() => runApp(Page1());

class Page1 extends StatefulWidget {
  final Advertiser advertiser;
  const Page1({Key key, this.advertiser}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressAppBar,
      child: Scaffold(
        appBar: AppBar(
            title: Text('PAYMENT'),
            backgroundColor: Colors.blueAccent,
          ),
      body: Column(children: <Widget>[
        Text('page1')
      ],)
    ));
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pop(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(advertiser: advertiser),
        ));
    return Future.value(false);
  }
}
 