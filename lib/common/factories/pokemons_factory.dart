import 'dart:convert';
import 'dart:ui';

import 'package:flutter_pokedex/common/models/pokemon_wrapper.dart';
import 'package:flutter_pokedex/common/services/pokemon_service.dart';
import 'package:flutter_pokedex/common/services/service_locator.dart';
import 'package:flutter_pokedex/common/utils/utils.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

import 'factory_base.dart';

/// This class is the Factory of [PokemonWrapper]. It will handle the [PokemonWrapper] requests and its local database.
class PokemonsFactory extends FactoryBase<PokemonWrapper> {
  late String boxName = 'POKEMONS_BOX';
  late String metadataBoxName = 'POKEMONS_METADATA_BOX';

  PokemonsFactory() : super(PokemonWrapperAdapter());

  /// Returns a list of [Pokemons].
  ///
  /// If it is not in local database, it will save it.
  /// TODO: Implement pagination
  Future<List<Pokemon?>> getPokemons([bool doPrefetch = true]) async {
    try {
      List<PokemonWrapper> pokemons = box.values.toList();
      //save into factory
      if (pokemons.isEmpty) {
        List<Pokemon?> pokemonsList =
        await locator<PokemonService>().getPokemonListFirstPage();

        //Create a pokemonWrapper for each pokemon, and save it to persistent storage
        pokemons = pokemonsList
            .map((e) => PokemonWrapper(serializedPokemon: jsonEncode(e!.toJson()), captured: false))
            .toList();

        //Update local last update time to use it to invalidate cache (not needed for this project yet)
        updateLocalLastUpdate();

        if (pokemons.isNotEmpty ) {
          Map<dynamic, PokemonWrapper> pokemonsMap = { for (var e in pokemons) jsonDecode( e.serializedPokemon)['id'] : e };
          if (box.isOpen) box.putAll(pokemonsMap);
        }
      }

      //Unwrap pokemons list
      List<Pokemon?> returnList = pokemons.map((e) => Pokemon.fromJson(jsonDecode(e.serializedPokemon)  as Map<String, dynamic>)).toList();

      if(doPrefetch){
        //Prefetch next page
        getAllPokemons();
      }

      return returnList;


    }catch(e){
      print("[PokemonsFactory] Error: $e");
      return <Pokemon?>[];
    }

  }

  /// Saves All [Pokemons] into Hive.
  ///
  ///
  Future<void> getAllPokemons() async {
    List<Pokemon?> pokemonsList =
        await locator<PokemonService>().getAllPokemons();

    //Create a pokemonWrapper for each pokemon, and save it to persistent storage
    List<PokemonWrapper> pokemons = pokemonsList
        .map((e) => PokemonWrapper(serializedPokemon: jsonEncode(e!.toJson()), captured: false))
        .toList();

    //Update local last update time to use it to invalidate cache (not needed for this project yet)
    updateLocalLastUpdate();

    if (pokemons.isNotEmpty ) {
      Map<dynamic, PokemonWrapper> pokemonsMap = { for (var e in pokemons) jsonDecode( e.serializedPokemon)['id'] : e };
      if (box.isOpen) box.putAll(pokemonsMap);
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

  /// Release pokemon
  Future<void> releasePokemon(int id) async {
    PokemonWrapper? pokemon = box.get(id);
    if (pokemon != null) {
      pokemon.captured = false;
      box.put(id, pokemon);
    }
  }

  /// Returns if pokemon is captured
  bool isPokemonCaptured(int id) {
    PokemonWrapper? pokemon = box.get(id);
    if (pokemon != null) {
      return pokemon.captured;
    }
    return false;
  }

  /// Returns the predominant color of the captured pokemons
  Future<Color> getPredominantColor() async {
    List<PokemonWrapper> pokemons = box.values.toList();
    List<Color> colors = [];
    for (var pokemon in pokemons) {
      if (pokemon.captured) {
        Pokemon p = Pokemon.fromJson(jsonDecode(pokemon.serializedPokemon));
        colors.add(getColorType(p.types!.first.type!.name!)!);
      }
    }
    if (colors.isEmpty) {
      return Color(0XFFD3D3D3); //BOSTON UNIVERSITY RED COLOR
    }
    return mostCommonColor(colors);
  }


  @override
  Future<void> checkCacheValidity() {
    // TODO: implement checkCacheValidity
    throw UnimplementedError();
  }

}
