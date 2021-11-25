import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/main.dart';
import 'package:testing/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Country(),
    );
  }
}

class Country extends StatefulWidget {
  const Country({Key? key}) : super(key: key);

  @override
  _Country createState() => _Country();
}

class _Country extends State<Country> {
  var items = [];
  var picture = [];
  var rank = [];
  var pp = [];
  @override
  void initState() {
    refreshUsers();
    super.initState();
  }

  Future refreshUsers() async {
    Uri uri =
        Uri.parse('https://scoresaber.com/api/players?page=1&countries=SE');
    final response = await http.get(uri);
    var data = json.decode(response.body);
    this.items = [];
    this.picture = [];
    this.rank = [];
    this.pp = [];
    setState(() {
      for (var i = 0; i < data.length; i++) {
        this.items.add(data[i]['name']);
        this.picture.add(data[i]['profilePicture']);
        this.rank.add(data[i]['countryRank']);
        this.pp.add(data[i]['pp']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(title: Text('Leaderboard')),
      body: RefreshIndicator(
        onRefresh: refreshUsers,
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                    backgroundImage: NetworkImage('${picture[index]}')),
                title: Text(
                  '${items[index]}',
                  //textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.pink[800],
                  ),
                ),
                subtitle: Text('PP: ${pp[index]}'),
                trailing: Text(
                  '${rank[index]}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.red,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
