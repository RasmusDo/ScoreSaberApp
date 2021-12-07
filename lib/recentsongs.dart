import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/class/songscores_class.dart';
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

class Song extends StatefulWidget {
  @override
  _SongState createState() => _SongState();
}

class _SongState extends State<Song> {
  int currentPage = 1;

  late int totalPages;

  List<SongScores> scores = [];

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
        "https://scoresaber.com/api/player/76561198356628789/scores?limit=50&sort=recent&page=$currentPage");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final songScores = songScoresFromJson(response.body);

      if (isRefresh) {
        scores = songScores;
      } else {
        scores.addAll(songScores);
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
        title: Text('Recent scores'),
      ),
      body: SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        onRefresh: () async {
          final songScores = await getLeaderboardData(isRefresh: true);
          if (songScores) {
            refreshController.refreshCompleted();
          } else {
            refreshController.refreshFailed();
          }
        },
        onLoading: () async {
          final songScores = await getLeaderboardData();
          if (songScores) {
            refreshController.loadComplete();
          } else {
            refreshController.loadFailed();
          }
        },
        child: ListView.separated(
          itemBuilder: (context, index) {
            final song = scores[index];
            final procent = scores[index].score.baseScore /
                scores[index].leaderboard.maxScore;
            var procent2 = procent * 100;

            //double num = double.parse((procent2).toStringAsFixed(2));
            if (procent2 < 99.99) {
              var procent2 = 'ha';
            } else {
              var procent2 = num;
            }

            return ExpansionTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(song.leaderboard.coverImage.toString()),
              ),
              title: Text(song.leaderboard.songName,
                  style: TextStyle(fontSize: 20, color: Colors.pink)),
              subtitle: Text(song.score.pp.toString() + ' pp'),
              trailing: Text(
                procent2.toString(),
                style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: 20,
                ),
              ),
              children: <Widget>[
                Card(
                    child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(18.0),
                          child:
                              Text('Combo: ' + song.score.maxCombo.toString(),
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                  )),
                        ),
                        Container(
                          padding: EdgeInsets.all(18),
                          child: Text(
                            song.leaderboard.difficulty.difficulty.toString() +
                                ' Stars',
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        )
                      ],
                    )
                  ],
                ))
              ],
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: scores.length,
        ),
      ),
    );
  }
}
