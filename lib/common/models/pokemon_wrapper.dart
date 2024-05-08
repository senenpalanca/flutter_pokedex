
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

part 'pokemon_wrapper.g.dart';
/// Pokemon wrapper used to save serialized pokemons into hive
@HiveType(typeId: 1)
class PokemonWrapper {

  @HiveField(0)
  final String serializedPokemon;

  @HiveField(1)
  bool captured;

  PokemonWrapper({required this.serializedPokemon, required this.captured});

  //get pokemon
  Pokemon getPokemon() {
    return Pokemon.fromJson(jsonDecode(serializedPokemon));
  }
}