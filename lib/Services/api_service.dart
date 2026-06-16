import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Models/champion.dart';

class ApiService {
  static const String _versionsUrl =
      'https://ddragon.leagueoflegends.com/api/versions.json';

  static Future<List<Champion>> fetchChampions() async {
    try {
      final versionResponse = await http.get(Uri.parse(_versionsUrl));
      if (versionResponse.statusCode != 200) {
        throw Exception('Nie udało się pobrać wersji API');
      }
      final List<dynamic> versions = json.decode(versionResponse.body);
      final String latestVersion = versions.first;
      final String championsUrl =
          'https://ddragon.leagueoflegends.com/cdn/$latestVersion/data/en_US/champion.json';
      final response = await http.get(Uri.parse(championsUrl));

      if (response.statusCode != 200) {
        throw Exception('Nie udało się pobrać danych bohaterów z API');
      }

      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> championsData = data['data'];

      final List<Champion> champions = championsData.values.map((json) {
        return Champion.fromJson(json, latestVersion);
      }).toList();

      return champions;
    } catch (e) {
      throw Exception('Wystąpił błąd podczas komunikacji z API: $e');
    }
  }
}
