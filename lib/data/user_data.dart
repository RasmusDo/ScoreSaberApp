import 'package:testing/class/user_class.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future wad() async {
  final response = await http.get(Uri.parse(
      'https://new.scoresaber.com/api/player/76561198356628789/full'));

  if (response.statusCode == 200) {
    print(json.decode(response.body)[
        'playerInfo']); // _InternalLinkedHashMap<String, dynamic>

    var info = json.decode(response.body)['playerInfo'];

    UserInfo walla = UserInfo.fromJson(info);
    print(walla.toString());
  } else {
    throw Exception('Failed to load');
  }
}

Future<UserInfo> fetchData() async {
  final response = await http.get(
      Uri.parse('https://new.scoresaber.com/api/player/2085408448198355/full'));

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