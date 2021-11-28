import 'package:testing/leaderboard_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List players = [];
  List filteredPlayers = [];
  bool isSearching = false;

  getPlayers() async {
    var response = await Dio().get('https://scoresaber.com/api/players?page=1');
    return response.data;
  }

  @override
  void initState() {
    getPlayers().then((data) {
      setState(() {
        players = filteredPlayers = data;
      });
    });
    super.initState();
  }

  void _filterPlayers(value) {
    setState(() {
      filteredPlayers = players
          .where((player) =>
              player['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: !isSearching
            ? Text('Leaderboard')
            : TextField(
                onChanged: (value) {
                  _filterPlayers(value);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white)),
              ),
        actions: <Widget>[
          isSearching
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      this.isSearching = false;
                      filteredPlayers = players;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filteredPlayers.length > 0
            ? ListView.builder(
                itemCount: filteredPlayers.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(PlayerPage.routeName,
                          arguments: filteredPlayers[index]);
                    },
                    child: Card(
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  filteredPlayers[index]['profilePicture']
                                      .toString()),
                            ),
                            title: Text(
                                filteredPlayers[index]['name'].toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFFAD1457))),
                            subtitle: Text(
                                filteredPlayers[index]['pp'].toString() +
                                    ' pp'),
                            trailing:
                                Text(filteredPlayers[index]['rank'].toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  );
                })
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
