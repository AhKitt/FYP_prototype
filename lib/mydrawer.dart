import 'package:flutter/material.dart';
import 'package:prototype3/advertiser.dart';
import 'package:prototype3/loginscreen.dart';

class MyDrawer extends StatelessWidget {
  final Advertiser advertiser;

  const MyDrawer({Key key, this.advertiser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
          // Important: Remove any padding from the ListView.
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.personal_video),
              title: Text('Your Advertisement'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.file_upload),
              title: Text('Advertise Advertisement'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
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
    );
  }

  Widget _createUserAccountHeader(){
    return UserAccountsDrawerHeader(
      accountName: Text('advertiser.name'),
      accountEmail: Text('advertiser.email'),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('assets/images/ahhh.jpg'),
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