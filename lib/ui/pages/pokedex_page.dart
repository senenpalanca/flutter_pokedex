import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/styles/colors.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemons_list_widget.dart';

import '../../common/styles/dimensions.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pokedex",
                  style: TextStyle(
                      fontSize: Dimens.textSizeBigTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title)),
              const Text(
                "Pokemons en la región de Kanto",
                style: TextStyle(
                    fontSize: Dimens.textSizeBodySmall,
                    color: AppColors.subtitle),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Buscar pokemon",
                    fillColor: Colors.grey[200],
                    suffixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const Expanded(child: PokemonsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
