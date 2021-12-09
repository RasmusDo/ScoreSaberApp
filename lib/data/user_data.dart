import 'dart:io';

import 'package:testing/class/user_class.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class ApiCall {
  //FIX CALLS TO DESIRED PLAYER
  final String API_URL =
      "https://scoresaber.com/api/player/76561198356628789/full";

  Future<UserInfo> getUserDataResponse() async {
    String fileName = "cacheData.json";
    var cacheDir = await getTemporaryDirectory();

    if (await File(cacheDir.path + '/' + fileName).exists()) {
      print("Loading from cache");
      var jsonData = File(cacheDir.path + '/' + fileName).readAsStringSync();
      UserInfo response = UserInfo.fromJson(json.decode(jsonData));
      return response;
    } else {
      print("Loading from API");
      var response = await http.get(Uri.parse(API_URL));
      print(response);

      if (response.statusCode == 200) {
        var jsonResponse = response.body;
        UserInfo res = UserInfo.fromJson(jsonDecode(jsonResponse));

        var tempDir = await getTemporaryDirectory();
        File file = new File(tempDir.path + "/" + fileName);
        file.writeAsString(jsonResponse, flush: true, mode: FileMode.write);

        return res;
      } else {
        throw Exception('PROFILE API ERROR');
      }
    }
  }
}

Future<UserInfo> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://new.scoresaber.com/api/player/76561198356628789/full'));

  if (response.statusCode == 200) {
    return UserInfo.fromJson(jsonDecode(response.body)['playerInfo']);

    /*   var info = json.decode(response.body)['playerInfo'];
      UserInfo walla = UserInfo.fromJson(info);
    
    print(json.decode(response.body)[
        'playerInfo']); // _InternalLinkedHashMap<String, dynamic>
    
    print(walla.toString());
    */
  } else {
    throw Exception('Failed to load');
  }
}









/*
Future<LeaderBoardInfo> globalFetch() async {
  final response =
      await http.get(Uri.parse('https://scoresaber.com/api/players?page=1'));

  if (response.statusCode == 200) {
    return LeaderBoardInfo.fromJson(jsonDecode(response.body));

    /*   var info = json.decode(response.body)['playerInfo'];
      UserInfo walla = UserInfo.fromJson(info);
    
    print(json.decode(response.body)[
        'playerInfo']); // _InternalLinkedHashMap<String, dynamic>
    
    print(walla.toString());
    */
  } else {
    throw Exception('Failed to load');
  }
}
*/