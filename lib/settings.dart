//flutter packages
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

//lib
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
  Future<void> _deleteCacheContents() async {
    print("walla");
    final cacheDir = await getTemporaryDirectory();
    String fileName = "cacheData.json";

    if (await File(cacheDir.path + "/" + fileName).exists()) {
      cacheDir.delete(recursive: true);
      print("Deleted the CacheJson file!!");
    }
  }

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
                subtitle: 'Set SSID',
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
            title: 'Settings',
            tiles: [
              SettingsTile(
                title: 'Remove Cache',
                subtitle: '',
                trailing: Icon(Icons.delete_forever),
                leading: Icon(Icons.memory),
                onPressed: (context) => _deleteCacheContents(),
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
