import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokemonService {
  Future<List<Pokemon?>> getPokemonList() async {
    return await PokeAPI.getObjectList<Pokemon>(1, 151);
  }
}
