import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/common/extensions/extensions.dart';
import 'package:flutter_pokedex/common/styles/colors.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';
import 'package:flutter_pokedex/common/utils/utils.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_type_card.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
    return Scaffold(body: _buildBody());
  }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Create a header of size 30% of the screen with background color of the type of the pokemon
        //and the main image of the pokemon in the center
        Container(
          decoration: BoxDecoration(
              borderRadius:
                  ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                      : null,
              color: getColorType(widget.pokemon.types?.first.type?.name ?? "")!
                  .withOpacity(0.4)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: widget.pokemon.id ?? "",
                    child: Image.network(
                      widget.pokemon.sprites?.frontDefault ?? "",
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

         Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text( //fIRST IN Uppercase
                  widget.pokemon.name!.capitalize(),
                  style: const TextStyle(
                      fontSize: Dimens.textSizeBigTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title)),
              Row(
                children: [
                  for (var type in widget.pokemon.types!)
                    PokemonTypeCard(type: type,)
                ],
              ),
              const SizedBox(
                height: 12,
              ),

              //All the properties of the pokemon
              for (var stat in widget.pokemon.stats!)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Text(
                        stat.stat?.name ?? "",
                        style: const TextStyle(
                            fontSize: Dimens.textSizeBodySmall,
                            color: AppColors.subtitle),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        stat.baseStat.toString(),
                        style: const TextStyle(
                            fontSize: Dimens.textSizeBodySmall,
                            color: AppColors.subtitle),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
