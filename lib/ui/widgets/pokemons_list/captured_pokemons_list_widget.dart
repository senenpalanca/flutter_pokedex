import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/globals/globals.dart';
import 'package:flutter_pokedex/common/models/pokemon_wrapper.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_card.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class CapturedPokemonsListWidget extends StatefulWidget {
  const CapturedPokemonsListWidget({super.key});

  @override
  State<CapturedPokemonsListWidget> createState() =>
      _CapturedPokemonsListWidgetState();
}

class _CapturedPokemonsListWidgetState
    extends State<CapturedPokemonsListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: HiveListener<dynamic>(
        box: pokemonsFactory.box,
        builder: (box) {
          final pokemons = box.values
              .toList()
              .where((element) => element.captured)
              .toList();

          if(pokemons.isNotEmpty) {
            return SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (var pokemon in pokemons)
                      PokemonCard(pokemon: Pokemon.fromJson(jsonDecode(pokemon.serializedPokemon))),
                  ],
                ),
              );
          } else {
            return const Center(
              child: Text('No hay pokemons capturados'),
            );
          }
        },
      ),
    );
  }
}
