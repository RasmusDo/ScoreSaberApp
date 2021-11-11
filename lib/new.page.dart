import 'package:flutter/material.dart';
import 'package:testing/main.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('wdawd'),
        ),
      ),
    ),
  );
}

class ScoreSaberId {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/stuff.txt');
  }

  Future<int> readId() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return int.parse(contents);
    } catch (e) {
      return 0;
    }
  }

  Future<File> writeId(int id) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$id');
  }
}

class MySSID extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MySSIDState();
}

class _MySSIDState extends State<MySSID> {
  final _scoreSaberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('SSID'),
          ),
          drawer: NavDrawer(),
          body: ListView(
            children: [
              ListTile(
                title: TextField(
                  controller: _scoreSaberController,
                  decoration: InputDecoration(labelText: 'ScoresaberID'),
                ),
              )
            ],
          )),
    );
  }
}
