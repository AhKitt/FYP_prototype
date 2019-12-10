import 'package:flutter/material.dart';
import 'package:prototype3/advertiser.dart';
import 'package:prototype3/loginscreen.dart';
import 'package:prototype3/loginscreen.dart' as prefix0;
import 'package:prototype3/page1.dart';

class MainScreen extends StatefulWidget {
  final Advertiser advertiser;

  const MainScreen({Key key,this.advertiser}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _createUserAccountHeader(),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Manage Profile'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page1(advertiser: advertiser)));
              },
            ),
            ListTile(
              leading: Icon(Icons.personal_video),
              title: Text('Your Advertisement'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: Text('Advertise Advertisement'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => Page1()));
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log out'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('MainScreen'),
      ),
      body: Text('this is main screen'),
    );
  }

  Future<bool> _onBackPressAppBar() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ));
    return Future.value(false);
  }

  Widget _createHeader(){ //This is drawer header
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        //color: Colors.blue,
          image: DecorationImage(
            fit: BoxFit.fill,
            image:  AssetImage('assets/images/ahhh.jpg')
          )
      ),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Username",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ])
    );
  }

  Widget _createUserAccountHeader(){
    return UserAccountsDrawerHeader(
      accountName: Text('widget.advertiser.name'),
      accountEmail: Text('widget.advertiser.email'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/images/download2.jpg'),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image:  AssetImage('assets/images/pic1.jpg')
        )
      ),
    );
  }

  Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
}