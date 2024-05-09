import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';
import 'package:flutter_pokedex/common/utils/utils.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokemonTypeCard extends StatelessWidget {
  final Types type;
  const PokemonTypeCard({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0),
      child: Container(
        margin: const EdgeInsets.only(right: 4),
        padding: const EdgeInsets.symmetric(
            vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: getColorType(
              type.type?.name ?? "")!.withOpacity(
              0.7),
        ),
        child: Text(
          type.type?.name ?? "",
          style: const TextStyle(
              fontSize: 12,
              color: Colors.white),
        ),
      ),
    );
  }
}
