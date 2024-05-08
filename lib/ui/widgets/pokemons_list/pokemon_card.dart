import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/extensions/extensions.dart';
import 'package:flutter_pokedex/common/models/pokemon_wrapper.dart';
import 'package:flutter_pokedex/common/routes/route_service.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';
import 'package:flutter_pokedex/common/utils/utils.dart';
import 'package:flutter_pokedex/ui/pages/pokemon_detail_page.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_type_card.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PokemonCard extends StatelessWidget {
  final PokemonWrapper pokemonWrapper;
  const PokemonCard({super.key, required this.pokemonWrapper});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.POKEMON_DETAIL_PAGE,
              arguments: PokemonArguments(pokemonWrapper.getPokemon(), false));
        },
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Container(
                //height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: getColorType(
                          pokemonWrapper.getPokemon().types?.first.type?.name ??
                              "")!
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
                          Text(
                              pokemonWrapper.getPokemon().name?.capitalize() ??
                                  "",
                              style: const TextStyle(
                                  fontSize: Dimens.textSizeBody,
                                  color: Colors.white)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var type
                                  in pokemonWrapper.getPokemon().types!)
                                PokemonTypeCard(
                                  type: type,
                                )
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
                    Image.network(
                      pokemonWrapper.getPokemon().sprites?.frontDefault ?? "",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            if(ResponsiveBreakpoints.of(context).largerThan(MOBILE))
            Positioned(
              right: 20,
              top: 10,
              child:  Text(
                "# ${pokemonWrapper.getPokemon().id.toString()}",
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.white.withOpacity(0.3),
                    fontWeight: Dimens.fontWeightBold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
