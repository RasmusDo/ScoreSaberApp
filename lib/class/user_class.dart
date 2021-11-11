class UserInfo {
  final String playerId;
  final String playerName;
  final String avatar;
  final int rank;
  final int countryRank;
  final double pp;
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
      pp: json['contryRank'],
      country: json['country'],
    );
  }
}
