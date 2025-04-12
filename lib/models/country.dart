class Country {
  final String country;
  final String flagImageUrl;
  final int population;
  final int areaKm2;
  final String countryCode;

  Country({
    required this.country,
    required this.flagImageUrl,
    required this.population,
    required this.areaKm2,
    required this.countryCode,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      country: json['country'],
      flagImageUrl: json['flag_image_url'],
      population: json['population'],
      areaKm2: json['area_km2'],
      countryCode: json['country_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'flag_image_url': flagImageUrl,
      'population': population,
      'area_km2': areaKm2,
      'country_code': countryCode,
    };
  }
}
