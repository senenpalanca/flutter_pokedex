import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/globals/globals.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_card.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CapturedPokemonsListWidget extends StatefulWidget {

  final bool orderAlphabetically;

  const CapturedPokemonsListWidget({super.key, this.orderAlphabetically = false});

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
            if(widget.orderAlphabetically) {
              pokemons.sort((a, b) {
                var pokemonA = Pokemon.fromJson(jsonDecode(a.serializedPokemon));
                  var pokemonB = Pokemon.fromJson(jsonDecode(b.serializedPokemon));
                return pokemonA.name!.compareTo(pokemonB.name!);
            }); }

            //serializedPokemons = serializedPokemons.where((element) => element.name!.contains(widget.searchText)).toList();

            //Use Breakpoints to set crossAxisCount
            int crossAxisCount = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET) ? 2 : ResponsiveBreakpoints.of(context).smallerOrEqualTo(DESKTOP) ? 3 : ResponsiveBreakpoints.of(context).smallerOrEqualTo(BIG_DESKTOP) ? 4 : 5;

            return GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 200 / 170,
              ),
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                return PokemonCard(
                    pokemonWrapper: pokemons[index],
                );
              },
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
