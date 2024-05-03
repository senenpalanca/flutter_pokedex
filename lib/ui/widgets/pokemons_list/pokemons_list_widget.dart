import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/services/pokemon_service.dart';
import 'package:flutter_pokedex/common/services/service_locator.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_card.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokemonsListWidget extends StatefulWidget {
  final String searchText;
  const PokemonsListWidget({super.key, required this.searchText});

  @override
  State<PokemonsListWidget> createState() => _PokemonsListWidgetState();
}

class _PokemonsListWidgetState extends State<PokemonsListWidget> {
  @override
  Widget build(BuildContext context) {
    // Use pokemon service to retrieve all pokemons with getPokemonList()

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: FutureBuilder<List<Pokemon?>>(
        future: locator<PokemonService>().getPokemonList(widget.searchText),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Error'),
            );
          }
          return SingleChildScrollView(
            child: Wrap(
              children: [
                for (var pokemon in snapshot.data!)
                  PokemonCard(pokemon: pokemon!),
              ],
            ),
          );

        },
      ),
    );
  }
}
