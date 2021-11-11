import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/main.dart';

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
      home: Leaderboard(),
    );
  }
}

class Leaderboard extends StatefulWidget {
  const Leaderboard({Key? key}) : super(key: key);

  @override
  _Leaderboard createState() => _Leaderboard();
}

class _Leaderboard extends State<Leaderboard> {
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
    Uri uri = Uri.parse('https://new.scoresaber.com/api/players/1');
    final response = await http.get(uri);
    var data = json.decode(response.body);
    this.items = [];
    this.picture = [];
    this.rank = [];
    this.pp = [];
    setState(() {
      for (var i = 0; i < data['players'].length; i++) {
        this.items.add(data['players'][i]['playerName']);
        this.picture.add(data['players'][i]['avatar']);
        this.rank.add(data['players'][i]['rank']);
        this.pp.add(data['players'][i]['pp']);
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
                    backgroundImage: NetworkImage(
                        'https://new.scoresaber.com' + '${picture[index]}')),
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
