import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/routes/route_service.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.POKEMON_DETAIL_PAGE, arguments: pokemon);
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Container(
                height: 130,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),

                  color: getColorType(pokemon.types?.first.type?.name ?? "")!
                      .withAlpha(150),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var type in pokemon.types!)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: getColorType(type.type?.name ?? "")!.withOpacity(0.7),
                                    ),
                                    child: Text(
                                      type.type?.name ?? "",
                                      style: const TextStyle(
                                          fontSize: Dimens.textSizeBodyTiny,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Hero(
                      tag: pokemon.id ?? "",
                      child: Image.network(
                        pokemon.sprites?.frontDefault ?? "",
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
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
