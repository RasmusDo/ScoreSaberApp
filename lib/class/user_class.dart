import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
  UserInfo({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.country,
    required this.pp,
    required this.rank,
    required this.countryRank,
    required this.role,
    required this.badges,
    required this.histories,
    required this.permissions,
    required this.banned,
    required this.inactive,
  });

  String id;
  String name;
  String profilePicture;
  String country;
  double pp;
  int rank;
  int countryRank;
  dynamic role;
  List<dynamic> badges;
  String histories;
  int permissions;
  bool banned;
  bool inactive;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        country: json["country"],
        pp: json["pp"].toDouble(),
        rank: json["rank"],
        countryRank: json["countryRank"],
        role: json["role"],
        badges: List<dynamic>.from(json["badges"].map((x) => x)),
        histories: json["histories"],
        permissions: json["permissions"],
        banned: json["banned"],
        inactive: json["inactive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profilePicture": profilePicture,
        "country": country,
        "pp": pp,
        "rank": rank,
        "countryRank": countryRank,
        "role": role,
        "badges": List<dynamic>.from(badges.map((x) => x)),
        "histories": histories,
        "permissions": permissions,
        "banned": banned,
        "inactive": inactive,
      };
}

//GLOBAL LEADERBOARD CLASS

List<Leaderboard> leaderboardFromJson(String str) => List<Leaderboard>.from(
    json.decode(str).map((x) => Leaderboard.fromJson(x)));

String leaderboardToJson(List<Leaderboard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Leaderboard {
  Leaderboard({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.country,
    required this.pp,
    required this.rank,
    required this.countryRank,
    required this.badges,
    required this.histories,
    required this.permissions,
    required this.banned,
    required this.inactive,
  });

  String id;
  String name;
  String profilePicture;
  String country;
  double pp;
  int rank;
  int countryRank;
  dynamic badges;
  String histories;
  int permissions;
  bool banned;
  bool inactive;

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        id: json["id"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        country: json["country"],
        pp: json["pp"].toDouble(),
        rank: json["rank"],
        countryRank: json["countryRank"],
        badges: json["badges"],
        histories: json["histories"],
        permissions: json["permissions"],
        banned: json["banned"],
        inactive: json["inactive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profilePicture": profilePicture,
        "country": country,
        "pp": pp,
        "rank": rank,
        "countryRank": countryRank,
        "badges": badges,
        "histories": histories,
        "permissions": permissions,
        "banned": banned,
        "inactive": inactive,
      };
}

//LEADERBOARD PROFILE PAGE

// To parse this JSON data, do
//
//     final leaderboardProfile = leaderboardProfileFromJson(jsonString);

LeaderboardProfile leaderboardProfileFromJson(String str) =>
    LeaderboardProfile.fromJson(json.decode(str));

String leaderboardProfileToJson(LeaderboardProfile data) =>
    json.encode(data.toJson());

class LeaderboardProfile {
  LeaderboardProfile({
    required this.id,
    required this.name,
    required this.profilePicture,
    required this.country,
    required this.pp,
    required this.rank,
    required this.countryRank,
    required this.role,
    required this.badges,
    required this.histories,
    required this.permissions,
    required this.banned,
    required this.inactive,
  });

  String id;
  String name;
  String profilePicture;
  String country;
  int pp;
  int rank;
  int countryRank;
  String role;
  List<Badge> badges;
  String histories;
  int permissions;
  bool banned;
  bool inactive;

  factory LeaderboardProfile.fromJson(Map<String, dynamic> json) =>
      LeaderboardProfile(
        id: json["id"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        country: json["country"],
        pp: json["pp"],
        rank: json["rank"],
        countryRank: json["countryRank"],
        role: json["role"],
        badges: List<Badge>.from(json["badges"].map((x) => Badge.fromJson(x))),
        histories: json["histories"],
        permissions: json["permissions"],
        banned: json["banned"],
        inactive: json["inactive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profilePicture": profilePicture,
        "country": country,
        "pp": pp,
        "rank": rank,
        "countryRank": countryRank,
        "role": role,
        "badges": List<dynamic>.from(badges.map((x) => x.toJson())),
        "histories": histories,
        "permissions": permissions,
        "banned": banned,
        "inactive": inactive,
      };
}

class Badge {
  Badge({
    required this.description,
    required this.image,
  });

  String description;
  String image;

  factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        description: json["description"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "image": image,
      };
}
