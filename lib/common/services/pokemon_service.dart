import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokemonService {
  Future<List<Pokemon?>> getPokemonListFirstPage() async {
    try {
      List<Pokemon?> results = await PokeAPI.getObjectList<Pokemon>(1, 10);
      return results;
    } catch (e) {
      return [];
    }
  }

  Future<List<Pokemon?>> getAllPokemons() async {
    try {
      List<Pokemon?> results = await PokeAPI.getObjectList<Pokemon>(1, 151);
      return results;
    } catch (e) {
      return [];
    }
  }
}
