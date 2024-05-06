import 'dart:convert';

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
  Future<List<Pokemon?>> getPokemons(String searchText, [bool doPrefetch = true]) async {
    try {
      List<PokemonWrapper> pokemons = box.values.toList();
      //save into factory
      if (pokemons.isEmpty) {
        List<Pokemon?> pokemonsList =
        await locator<PokemonService>().getPokemonList(searchText);
        //Create a pokemonWrapper for each pokemon, and save it to persistent storage
        pokemons = pokemonsList
            .map((e) => PokemonWrapper(serializedPokemon: jsonEncode(e!.toJson()), captured: false))
            .toList();

        updateLocalLastUpdate();
        if (pokemons.isNotEmpty) {
          Map<dynamic, PokemonWrapper> pokemonsMap = { for (var e in pokemons) jsonDecode( e.serializedPokemon)['id'] : e };
          if (box.isOpen) box.putAll(pokemonsMap);
        }
      }

      //Unwrap pokemons list
      List<Pokemon?> returnList = pokemons.map((e) => Pokemon.fromJson(jsonDecode(e.serializedPokemon)  as Map<String, dynamic>)).toList();

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

  /// Capture pokemon
  Future<void> capturePokemon(int id) async {
    PokemonWrapper? pokemon = box.get(id);
    if (pokemon != null) {
      pokemon.captured = true;
      box.put(id, pokemon);
    }
  }

  @override
  Future<void> checkCacheValidity() {
    // TODO: implement checkCacheValidity
    throw UnimplementedError();
  }
}
