import 'package:flutter/material.dart';
import 'package:testing/class/user_class.dart';
import 'package:testing/data/user_data.dart';
import 'package:testing/asd.dart';

///import 'package:shared_preferences/shared_preferences.dart';
//files
import 'package:testing/leaderboard.dart';
import 'package:testing/leaderboard_profile.dart';
import 'package:testing/new.page.dart';
import 'package:testing/settings.dart';
import 'package:testing/profile.dart';
import 'package:testing/contry.dart';
import 'package:testing/recentsongs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        //PlayerPage.routeName: (ctx) => PlayerPage(),
      },
      home: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('main'),
        ),
        body: MyCustomForm(),
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

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  late Future<UserInfo> futureData;

  @override
  void initState() {
    futureData = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserInfo>(
      future: futureData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                  ),
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://new.scoresaber.com${snapshot.data!.avatar}'),
                          backgroundColor: Colors.white,
                          radius: 50.0,
                        ),
                      ),
                      Align(
                          alignment: Alignment(0.5, 0),
                          child: Text('${snapshot.data!.playerName}',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20.0))),
                      Align(
                        alignment: Alignment(0.2, 0.4),
                        child: Text('PP: ${snapshot.data!.pp}',
                            style: TextStyle(color: Colors.blue)),
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
                      MaterialPageRoute(
                          builder: (context) => LeaderboardPage()),
                    )
                  },
                ),
                ListTile(
                  leading: Icon(Icons.flag),
                  title: Text('Contry'),
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CountryLeaderboardPage()),
                    ),
                  },
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
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
        // create some layout here
      },
    );
  }
}
