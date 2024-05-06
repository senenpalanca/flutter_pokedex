
import 'package:hive/hive.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

part 'pokemon_wrapper.g.dart';

@HiveType(typeId: 1)
class PokemonWrapper {

  @HiveField(0)
  final Map<String, dynamic> serializedPokemon;

  @HiveField(1)
  final bool captured;

  PokemonWrapper({required this.serializedPokemon, required this.captured});
}