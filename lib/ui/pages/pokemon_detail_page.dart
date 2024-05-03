import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokemonDetailPage extends StatefulWidget {

  final Pokemon pokemon;

  const PokemonDetailPage({super.key, required this.pokemon});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) {
    // Use widget.pokemon to display the pokemon details
    // Also, show a header with the main image of the pokemon at the top, and the bottom color of the header has to be the default of the pokemon
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pokemon.name ?? ""),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.pokemon.id ?? "",
            child: Image.network(
              widget.pokemon.sprites?.frontDefault ?? "",
              width: 200,
              height: 200,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Height: ${widget.pokemon.height}"),
                Text("Weight: ${widget.pokemon.weight}"),
                Text("Base experience: ${widget.pokemon.baseExperience}"),
                Text("Abilities:"),
                for (var ability in widget.pokemon.abilities!)
                  Text(ability.ability?.name ?? ""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
