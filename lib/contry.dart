import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/class/user_class.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:testing/leaderboard_profile.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class CountryLeaderboardPage extends StatefulWidget {
  @override
  _CountryLeaderboardPageState createState() => _CountryLeaderboardPageState();
}

class _CountryLeaderboardPageState extends State<CountryLeaderboardPage> {
  int currentPage = 1;

  late int totalPages;

  List<Leaderboard> players = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  Future<bool> getLeaderboardData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }

    final Uri uri = Uri.parse(
        //https://scoresaber.com/api/players?page=1
        "https://scoresaber.com/api/players?page=$currentPage&countries=SE");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = leaderboardFromJson(response.body);

      if (isRefresh) {
        players = result;
      } else {
        players.addAll(result);
      }

      currentPage++;

      totalPages = 100;

      print(response.body);
      setState(() {});
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Country Leaderboard"),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final result = await getLeaderboardData(isRefresh: true);
          if (result) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final result = await getLeaderboardData();
          if (result) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final player = players[index];

            return ListTile(
              tileColor: Colors.black87,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(player.profilePicture.toString()),
              ),
              title: Text(player.name,
                  style: TextStyle(fontSize: 20, color: Colors.pink)),
              subtitle: Text(player.pp.toString() + ' pp',
                  style: TextStyle(color: Colors.blue)),
              onTap: () {
                String textToSend = player.id.toString();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlayerPage(
                              text: textToSend,
                            )));
              },
              trailing: Text(
                player.countryRank.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: players.length,
        ),
      ),
    );
  }
}
