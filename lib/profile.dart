import 'dart:async';
import 'package:testing/main.dart';

import 'dart:convert';
import 'package:testing/class/user_class.dart';
import 'package:testing/data/user_data.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const ProfilePage());

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  late Future<UserInfo> futureData;
  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<UserInfo>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'LOL',
                        child: Container(
                          height: 125.0,
                          width: 125.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(62.5),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://new.scoresaber.com${snapshot.data!.avatar}'))),
                        ),
                      ),
                      SizedBox(height: 25.0),
                      Text(
                        '${snapshot.data!.playerName}',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'PP: ${snapshot.data!.pp}',
                        style: TextStyle(
                            fontFamily: 'Montserrat', color: Colors.grey),
                      ),
                      Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'COUNTRY',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  '${snapshot.data!.country}',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'RANK',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  '${snapshot.data!.rank}',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'LOCAL',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5.0),
                                Text(
                                  '${snapshot.data!.countryRank}',
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: Colors.grey),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {},
                                child: const Text('Recent Scores')),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 20),
                              ),
                              onPressed: () => {fetchData()},
                              child: const Text('Top Scores'),
                            ),
                          ],
                        ),
                      ),
                      buildInfoDetail(),
                    ]);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Widget buildInfoDetail() {
  return Padding(
    padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 10.0, bottom: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'map',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  fontSize: 15.0),
            ),
            SizedBox(height: 7.0),
            Row(
              children: <Widget>[
                Text(
                  'hkjhjg',
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontFamily: 'Montserrat',
                      fontSize: 11.0),
                ),
                SizedBox(width: 4.0),
                Icon(
                  Icons.timer,
                  size: 4.0,
                  color: Colors.black,
                ),
                SizedBox(width: 4.0),
                Text(
                  '3 pp',
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontFamily: 'Montserrat',
                      fontSize: 11.0),
                )
              ],
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(width: 7.0),
            InkWell(
              onTap: () {},
              child: Container(
                height: 20.0,
                width: 20.0,
              ),
            ),
            SizedBox(width: 7.0),
            InkWell(
              onTap: () {},
              child: Container(
                height: 20.0,
                width: 20.0,
              ),
            ),
            SizedBox(width: 7.0),
            InkWell(
              onTap: () {},
              child: Container(
                height: 22.0,
                width: 22.0,
              ),
            )
          ],
        )
      ],
    ),
  );
}
