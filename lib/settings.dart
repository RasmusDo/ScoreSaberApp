import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';


import 'package:testing/main.dart';


class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      home: MySettingsPage(title: 'Settings'),
    );
  }
}

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  
  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: NavDrawer(),
      body: SettingsList(
        sections: [
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Profile',
            tiles: [
              SettingsTile(
                title: 'SSID',
                subtitle: 'Scoreaber ID',
                leading: Icon(Icons.person_search),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use System Theme',
                leading: Icon(Icons.phone_android),
                switchValue: isSwitched,
                onToggle: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            ],
          ),
          SettingsSection(
            titlePadding: EdgeInsets.all(20),
            title: 'Usage',
            tiles: [
              SettingsTile(
                title: 'Security',
                subtitle: 'cache',
                leading: Icon(Icons.memory),
                onPressed: (BuildContext context) {},
              ),
              SettingsTile.switchTile(
                title: 'Use Darkmode',
                leading: Icon(Icons.dark_mode),
                switchValue: false,
                onToggle: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}