class Country {
  final String name;
  final String flagPngUrl;
  final String flagEmoji;
  final String cca3;

  Country({
    required this.name,
    required this.flagPngUrl,
    required this.flagEmoji,
    required this.cca3,
  });
  factory Country.fromJson(Map<String, dynamic> json) {
    final name = json['name']?['common'] ?? '';
    final flagPngUrl = json['flags']?['png'] ?? '';
    final flagEmoji = json['flag'] ?? '';
    final cca3 = json['cca3'] ?? '';

    return Country(
      name: name,
      flagPngUrl: flagPngUrl,
      flagEmoji: flagEmoji,
      cca3: cca3,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'flagPngUrl': flagPngUrl,
      'flagEmoji': flagEmoji,
      'cca3': cca3,
    };
  }
}
