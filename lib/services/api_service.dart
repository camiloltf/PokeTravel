import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 1. Obtener información de un Pokémon
  static Future fetchPokemon(String pokemonNameOrId) async {
    try {
      final url = Uri.parse(
        'https://pokeapi.co/api/v2/pokemon/${pokemonNameOrId.toLowerCase().trim()}'
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'name': data['name'],
          'imageUrl': data['sprites']['front_default'],
        };
      }
    } catch (e) {
      print('Error al buscar Pokémon: $e');
    }
    return null;
  }

  // 2. Obtener información de un país
  static Future fetchCountry(String countryName) async {
    try {
      final url = Uri.parse(
        'https://restcountries.com/v3.1/name/$countryName?fields=name,capital,flags,population'
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        if (data.isNotEmpty) {
          final country = data[0];
          return {
            'commonName': country['name']['common'],
            'capital': country['capital'] != null ? country['capital'][0] : 'No disponible',
            'flag': country['flags']['png'],
            'population': country['population'],
          };
        }
      }
    } catch (e) {
      print('Error al buscar país: $e');
    }
    return null;
  }
}