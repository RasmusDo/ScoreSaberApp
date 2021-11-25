class UserInfo {
  final String playerId;
  final String playerName;
  final String avatar;
  final int rank;
  final int countryRank;
  final num pp;
  final String country;

  UserInfo._(
      {required this.playerId,
      required this.playerName,
      required this.avatar,
      required this.countryRank,
      required this.rank,
      required this.pp,
      required this.country});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return new UserInfo._(
      playerId: json['playerId'],
      playerName: json['playerName'],
      avatar: json['avatar'],
      rank: json['rank'],
      countryRank: json['countryRank'],
      pp: json['pp'],
      country: json['country'],
    );
  }
}

class LeaderBoardInfo {
  final String id;
  final String name;
  final String picture;
  final String country;
  final String rank;
  final String pp;

  LeaderBoardInfo._({
    required this.id,
    required this.name,
    required this.picture,
    required this.country,
    required this.rank,
    required this.pp,
  });

  factory LeaderBoardInfo.fromJson(Map<String, dynamic> json) {
    return new LeaderBoardInfo._(
      id: json['id'],
      name: json['name'],
      picture: json['profilePicture'],
      country: json['country'],
      rank: json['rank'],
      pp: json['pp'],
    );
  }
}
