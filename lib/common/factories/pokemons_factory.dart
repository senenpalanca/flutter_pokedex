import 'package:flutter_pokedex/common/models/pokemon_wrapper.dart';
import 'package:flutter_pokedex/common/services/pokemon_service.dart';
import 'package:flutter_pokedex/common/services/service_locator.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

import 'factory_base.dart';

/// This class is the Factory of [PokemonWrapper]. It will handle the [PokemonWrapper] requests and its local database.
class PokemonsFactory extends FactoryBase<PokemonWrapper> {
  late String boxName = 'POKEMONS_BOX';
  late String metadataBoxName = 'POKEMONS_METADATA_BOX';

  PokemonsFactory() : super(PokemonWrapperAdapter());

  /// Returns a list of [Pokemons] r.
  ///
  /// If it is not in local database, it will save it.
  Future<List<Pokemon?>> getPokemons(String searchText) async {
    try {
      List<PokemonWrapper> pokemons = box.values.toList();

      //save into factory
      if (pokemons.isEmpty) {
        List<Pokemon?> pokemonsList =
        await locator<PokemonService>().getPokemonList(searchText);

        //Create a pokemonWrapper for each pokemon, and save it to persistent storage
        pokemons = pokemonsList
            .map((e) => PokemonWrapper(serializedPokemon: e!.toJson(), captured: false))
            .toList();

        updateLocalLastUpdate();
        if (pokemons.isNotEmpty) {
          Map<dynamic, PokemonWrapper> pokemonsMap = Map.fromIterable(pokemons,
              key: (e) => e.pokemon.id, value: (e) => e);
          if (box.isOpen) box.putAll(pokemonsMap);
        }
      }

      //Unwrap pokemons list
      List<Pokemon?> returnList = pokemons.map((e) => Pokemon.fromJson(e.serializedPokemon)).toList();

      if (searchText.isNotEmpty) {
        //Filter by searchText
        returnList = returnList
            .where(
                (element) =>
            element?.name?.contains(searchText) ?? false)
            .toList();
      }

      return returnList;


    }catch(e){
      print(e);
      return [];
    }

  }

  @override
  Future<void> checkCacheValidity() {
    // TODO: implement checkCacheValidity
    throw UnimplementedError();
  }
}
