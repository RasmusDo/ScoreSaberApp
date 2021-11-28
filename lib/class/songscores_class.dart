// To parse this JSON data, do
//
//     final songScores = songScoresFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<SongScores> songScoresFromJson(String str) =>
    List<SongScores>.from(json.decode(str).map((x) => SongScores.fromJson(x)));

String songScoresToJson(List<SongScores> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongScores {
  SongScores({
    required this.score,
    required this.leaderboard,
  });

  Score score;
  Leaderboard leaderboard;

  factory SongScores.fromJson(Map<String, dynamic> json) => SongScores(
        score: Score.fromJson(json["score"]),
        leaderboard: Leaderboard.fromJson(json["leaderboard"]),
      );

  Map<String, dynamic> toJson() => {
        "score": score.toJson(),
        "leaderboard": leaderboard.toJson(),
      };
}

class Leaderboard {
  Leaderboard({
    required this.id,
    required this.songHash,
    required this.songName,
    required this.songSubName,
    required this.songAuthorName,
    required this.levelAuthorName,
    required this.difficulty,
    required this.maxScore,
    required this.createdDate,
    required this.lovedDate,
    required this.ranked,
    required this.qualified,
    required this.loved,
    required this.maxPp,
    required this.stars,
    required this.plays,
    required this.dailyPlays,
    required this.positiveModifiers,
    required this.playerScore,
    required this.coverImage,
    required this.difficulties,
  });

  int id;
  String songHash;
  String songName;
  String songSubName;
  String songAuthorName;
  String levelAuthorName;
  Difficulty difficulty;
  int maxScore;
  DateTime createdDate;
  dynamic lovedDate;
  bool ranked;
  bool qualified;
  bool loved;
  int maxPp;
  double stars;
  int plays;
  int dailyPlays;
  bool positiveModifiers;
  dynamic playerScore;
  String coverImage;
  dynamic difficulties;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        id: json["id"],
        songHash: json["songHash"],
        songName: json["songName"],
        songSubName: json["songSubName"],
        songAuthorName: json["songAuthorName"],
        levelAuthorName: json["levelAuthorName"],
        difficulty: Difficulty.fromJson(json["difficulty"]),
        maxScore: json["maxScore"],
        createdDate: DateTime.parse(json["createdDate"]),
        lovedDate: json["lovedDate"],
        ranked: json["ranked"],
        qualified: json["qualified"],
        loved: json["loved"],
        maxPp: json["maxPP"],
        stars: json["stars"].toDouble(),
        plays: json["plays"],
        dailyPlays: json["dailyPlays"],
        positiveModifiers: json["positiveModifiers"],
        playerScore: json["playerScore"],
        coverImage: json["coverImage"],
        difficulties: json["difficulties"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "songHash": songHash,
        "songName": songName,
        "songSubName": songSubName,
        "songAuthorName": songAuthorName,
        "levelAuthorName": levelAuthorName,
        "difficulty": difficulty.toJson(),
        "maxScore": maxScore,
        "createdDate": createdDate.toIso8601String(),
        "lovedDate": lovedDate,
        "ranked": ranked,
        "qualified": qualified,
        "loved": loved,
        "maxPP": maxPp,
        "stars": stars,
        "plays": plays,
        "dailyPlays": dailyPlays,
        "positiveModifiers": positiveModifiers,
        "playerScore": playerScore,
        "coverImage": coverImage,
        "difficulties": difficulties,
      };
}

class Difficulty {
  Difficulty({
    required this.leaderboardId,
    required this.difficulty,
    required this.gameMode,
    required this.difficultyRaw,
  });

  int leaderboardId;
  int difficulty;
  String gameMode;
  String difficultyRaw;

  factory Difficulty.fromJson(Map<String, dynamic> json) => Difficulty(
        leaderboardId: json["leaderboardId"],
        difficulty: json["difficulty"],
        gameMode: json["gameMode"],
        difficultyRaw: json["difficultyRaw"],
      );

  Map<String, dynamic> toJson() => {
        "leaderboardId": leaderboardId,
        "difficulty": difficulty,
        "gameMode": gameMode,
        "difficultyRaw": difficultyRaw,
      };
}

class Score {
  Score({
    required this.id,
    required this.rank,
    required this.baseScore,
    required this.modifiedScore,
    required this.pp,
    required this.weight,
    required this.modifiers,
    required this.multiplier,
    required this.badCuts,
    required this.missedNotes,
    required this.maxCombo,
    required this.fullCombo,
    required this.hmd,
    required this.timeSet,
    required this.hasReplay,
  });

  int id;
  int rank;
  int baseScore;
  int modifiedScore;
  double pp;
  double weight;
  String modifiers;
  double multiplier;
  int badCuts;
  int missedNotes;
  int maxCombo;
  bool fullCombo;
  int hmd;
  DateTime timeSet;
  bool hasReplay;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        id: json["id"],
        rank: json["rank"],
        baseScore: json["baseScore"],
        modifiedScore: json["modifiedScore"],
        pp: json["pp"].toDouble(),
        weight: json["weight"].toDouble(),
        modifiers: json["modifiers"],
        multiplier: json["multiplier"].toDouble(),
        badCuts: json["badCuts"],
        missedNotes: json["missedNotes"],
        maxCombo: json["maxCombo"],
        fullCombo: json["fullCombo"],
        hmd: json["hmd"],
        timeSet: DateTime.parse(json["timeSet"]),
        hasReplay: json["hasReplay"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rank": rank,
        "baseScore": baseScore,
        "modifiedScore": modifiedScore,
        "pp": pp,
        "weight": weight,
        "modifiers": modifiers,
        "multiplier": multiplier,
        "badCuts": badCuts,
        "missedNotes": missedNotes,
        "maxCombo": maxCombo,
        "fullCombo": fullCombo,
        "hmd": hmd,
        "timeSet": timeSet.toIso8601String(),
        "hasReplay": hasReplay,
      };
}
