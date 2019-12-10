import 'package:flutter/material.dart';
import 'package:prototype3/advertiser.dart';
import 'package:prototype3/loginscreen.dart';
import 'package:prototype3/page1.dart';
import 'package:prototype3/page2.dart';

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  //final Advertiser advertiser;

  //const HomePage({Key key, this.advertiser}) : super(key: key);

  final drawerItems = [
    new DrawerItem("Manage Profile", Icons.person),
    new DrawerItem("Your Advertisement", Icons.personal_video),
    new DrawerItem("Advertise Advertisement", Icons.file_upload),
    new DrawerItem("Logout", Icons.exit_to_app),
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        //return new Page1();
      case 1:
        return new Page2();
      case 2:
        //return new Page1();
      case 3:
        return new LoginPage();

      default:
        return new Text("Error");
    }
  }
  
  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _selectedDrawerIndex,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/download2.jpg'),
              ),
              accountName: new Text("Hamyu"), 
              accountEmail: null,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image:  AssetImage('assets/images/pic1.jpg')
                )
              ),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}