import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/globals/globals.dart';
import 'package:flutter_pokedex/common/models/pokemon_wrapper.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_card.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
          print("Building Hive List");
          final pokemons = box.values
              .toList()
              .where((element) => element.captured)
              .toList();

          if(pokemons.isNotEmpty) {
            //Use Breakpoints to set crossAxisCount
            int crossAxisCount = ResponsiveBreakpoints.of(context).smallerOrEqualTo(TABLET) ? 2 : ResponsiveBreakpoints.of(context).smallerOrEqualTo(DESKTOP) ? 3 : ResponsiveBreakpoints.of(context).smallerOrEqualTo(BIG_DESKTOP) ? 4 : 5;

            return GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 200 / 170,
              ),
              itemCount: pokemons.length +  (limitPage > pokemons.length ? 1 : 0),
              itemBuilder: (context, index) {
                if(index == pokemons.length && limitPage > pokemons.length) {
                  return const Center(child: CircularProgressIndicator(),);
                }
                return PokemonCard(
                    pokemonWrapper: pokemons[index],
                );
              },
            );
            return SingleChildScrollView(
                child: Wrap(
                  children: [
                    for (var pokemon in pokemons)
                      PokemonCard(pokemonWrapper: pokemon),
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
