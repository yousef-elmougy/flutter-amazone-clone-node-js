class Analytics {
  final num totalEarning;
  final num mobileEarning;
  final num electronicsEarning;
  final num essentialsEarning;
  final num appliancesEarning;
  final num booksEarning;
  final num fashionEarning;

  const Analytics({
    required this.totalEarning,
    required this.mobileEarning,
    required this.electronicsEarning,
    required this.essentialsEarning,
    required this.appliancesEarning,
    required this.booksEarning,
    required this.fashionEarning,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) => Analytics(
        totalEarning: json["totalEarning"],
        mobileEarning: json["mobileEarning"],
        electronicsEarning: json["electronicsEarning"],
        essentialsEarning: json["essentialsEarning"],
        appliancesEarning: json["appliancesEarning"],
        booksEarning: json["booksEarning"],
        fashionEarning: json["fashionEarning"],
      );

  Map<String, dynamic> toJson() => {
        "totalEarning": totalEarning,
        "mobileEarning": mobileEarning,
        "electronicsEarning": electronicsEarning,
        "essentialsEarning": essentialsEarning,
        "appliancesEarning": appliancesEarning,
        "booksEarning": booksEarning,
        "fashionEarning": fashionEarning,
      };

}
