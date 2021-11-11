import 'package:flutter/material.dart';

///import 'package:shared_preferences/shared_preferences.dart';
//files
import 'package:testing/leaderboard.dart';
import 'package:testing/new.page.dart';
import 'package:testing/settings.dart';
import 'package:testing/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('main'),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your scoresaber ID',
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: ElevatedButton(
            onPressed: null,
            child: Text('Submit'),
          ),
        ),
      ],
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.yellow,
            ),
            child: Stack(
              children: const <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://variety.com/wp-content/uploads/2020/12/Dwayne_Johnson.png?w=970'),
                    backgroundColor: Colors.white,
                    radius: 50.0,
                  ),
                ),
                Align(
                    alignment: Alignment(0.5, 0),
                    child: Text('Username',
                        style: TextStyle(color: Colors.black, fontSize: 20.0))),
                Align(
                  alignment: Alignment(0.2, 0.4),
                  child: Text('PP: ', style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySSID()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              ),
            },
          ),
          ListTile(
            leading: Icon(Icons.leaderboard),
            title: Text('Leaderboard'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Leaderboard()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text('Contry'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              ),
            },
          ),
        ],
      ),
    );
  }
}
