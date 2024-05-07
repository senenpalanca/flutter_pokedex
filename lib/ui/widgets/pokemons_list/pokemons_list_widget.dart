import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/globals/globals.dart';
import 'package:flutter_pokedex/common/models/pokemon_wrapper.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_card.dart';
import 'package:hive/hive.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PokemonsListWidget extends StatefulWidget {
  final String searchText;
  const PokemonsListWidget({super.key, required this.searchText});

  @override
  State<PokemonsListWidget> createState() => _PokemonsListWidgetState();
}

class _PokemonsListWidgetState extends State<PokemonsListWidget> {
  bool _isLoading = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _loadPokemons();
    });
    super.initState();
  }

  //If widget.searchText changes, reload the pokemons
  @override
  void didUpdateWidget(covariant PokemonsListWidget oldWidget) {
    if (oldWidget.searchText != widget.searchText) {
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : HiveListener<dynamic>(
                box: pokemonsFactory.box,
                builder: (box) {
                  final pokemons = box.values.toList();

                  if (pokemons.isNotEmpty) {
                    var serializedPokemons = pokemons
                        .map((e) => Pokemon.fromJson(jsonDecode(e!.serializedPokemon)))
                        .toList();

                    if(widget.searchText.isNotEmpty) {
                      serializedPokemons = serializedPokemons.where((element) => element.name!.contains(widget.searchText)).toList();
                    }
                    //Use Breakpoints to set crossAxisCount
                    int crossAxisCount = ResponsiveBreakpoints.of(context)
                            .smallerOrEqualTo(TABLET)
                        ? 2
                        : ResponsiveBreakpoints.of(context)
                                .smallerOrEqualTo(DESKTOP)
                            ? 3
                            : ResponsiveBreakpoints.of(context)
                                    .smallerOrEqualTo(BIG_DESKTOP)
                                ? 4
                                : 5;
                    //Return a gridview builder of pokemons
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 200 / 160,
                      ),
                      itemCount: pokemons.length +
                          (pokemons.length <= limitPage  &&
                                  widget.searchText.isEmpty //No pagination when searching
                              ? 1
                              : 0),
                      itemBuilder: (context, index) {
                        if(index == pokemons.length && limitPage > pokemons.length) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return PokemonCard(
                          pokemonWrapper: pokemons[index]!,
                        );
                      },
                    );

                  } else {
                    return const Center(
                      child: Text('No hay pokemons capturados'),
                    );
                  }
                },
              ));
  }

  void _loadPokemons() async {
    setState(() {
      _isLoading = true;
    });
    await pokemonsFactory.getPokemons().then((value) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}
