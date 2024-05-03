import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child:  Stack(
        children: [

          Container(
              height: 100,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.withOpacity(0.5), width: 1),
                color: getColorType(pokemon.types?.first.type?.name ?? "")!.withAlpha(150),),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(pokemon.name ?? "",
                            style: const TextStyle(
                                fontSize: Dimens.textSizeBody,
                                color: Colors.white)),
                      ],
                    ),
                    /* Image.network(
                              pokemon.sprites?.frontDefault ?? "",
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),*/
                  ],
                ),
              )),
          Positioned(
            right: 0,
            bottom: 0,
            child: Image.network(
              pokemon.sprites?.frontDefault ?? "",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          )

        ],
      ),
    );
  }

  Color? getColorType(String type) {
    switch (type) {
      case 'normal':
        return Colors.brown[400];

      case 'fire':
        return Colors.red;

      case 'water':
        return Colors.blue;

      case 'grass':
        return Colors.green;

      case 'electric':
        return Colors.amber;

      case 'ice':
        return Colors.cyanAccent[400];

      case 'fighting':
        return Colors.orange;

      case 'poison':
        return Colors.purple;

      case 'ground':
        return Colors.orange[300];

      case 'flying':
        return Colors.indigo[200];

      case 'psychic':
        return Colors.pink;

      case 'bug':
        return Colors.lightGreen[500];

      case 'rock':
        return Colors.grey;

      case 'ghost':
        return Colors.indigo[400];

      case 'dark':
        return Colors.brown;

      case 'dragon':
        return Colors.indigo[800];

      case 'steel':
        return Colors.blueGrey;

      case 'fairy':
        return Colors.pinkAccent[100];

      default:
        return Colors.grey;
    }
  }
}
