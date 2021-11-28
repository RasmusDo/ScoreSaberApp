import 'package:flutter/material.dart';
import 'package:testing/class/user_class.dart';

class PlayerPage extends StatefulWidget {
  final String text;
  static const routeName = '/name';

  PlayerPage({Key? key, required this.text}) : super(key: key);

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('page'),
        ),
        body: Text('${widget.text}'));
  }
}
