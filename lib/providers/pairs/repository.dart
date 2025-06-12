import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pairs_game/models/country.dart';

class PairsRepository {
  String baseUrl = 'https://restcountries.com/v3.1';

  Future<List<Country>> fetchCountries(List<String> countryCodes) async {
    try {
      final Uri uri = Uri.parse('$baseUrl/alpha').replace(
        queryParameters: {
          'fields': 'flags,name,cca3,flag',
          'codes': countryCodes.join(","),
        },
      );

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((countryData) => Country.fromJson(countryData))
            .toList();
      } else {
        throw Exception('Failed to load countries: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch countries: $e');
    }
  }
}

final pairsRepositoryProvider = Provider<PairsRepository>((ref) {
  return PairsRepository();
});
