import 'package:flutter/material.dart';
import 'package:prototype3/page1.dart';
import 'package:prototype3/page2.dart';
//import 'package:prototype3/page3.dart';
import 'advertiser.dart';

class MainScreen3 extends StatefulWidget {
  final Advertiser advertiser;

  const MainScreen3({Key key, this.advertiser}) : super(key: key);

  @override
  _MainScreen3State createState() => _MainScreen3State();
}

class _MainScreen3State extends State<MainScreen3> {
  List<Widget> pages;

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      //Page1(advertiser: widget.advertiser),
      //Page2(advertiser: widget.advertiser),
      //Page3(advertiser: widget.advertiser)
    ];
  }

  String $pagetitle = "LBAS";

  onTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
         return Scaffold(
           drawer: Drawer(
             
           ),
        body: pages[currentPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentPageIndex,
          type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Jobs"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event, ),
              title: Text("My Jobs"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, ),
              title: Text("Profile"),
            )
          ],
        ),
      );
  }
}
