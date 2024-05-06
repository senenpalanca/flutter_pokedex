import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokemonService {
  Future<List<Pokemon?>> getPokemonList(String searchText) async {

    List<Pokemon?> results = await PokeAPI.getObjectList<Pokemon>(1, 151);

    //Filter results by search text in name
    if (searchText.isNotEmpty) {
      results = results.where((element) => element?.name?.contains(searchText) ?? false).toList();
    }

    return results;
  }
}
