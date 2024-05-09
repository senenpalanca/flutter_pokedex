import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/styles/colors.dart';
import 'package:flutter_pokedex/common/utils/debouncer.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemons_list_widget.dart';

import '../../common/styles/dimensions.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {

  String _searchText =  "";
  final _debouncer = Debouncer(milliseconds: 1000);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Pokédex",
                  style: TextStyle(
                      fontSize: Dimens.textSizeBigTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title)),
              const Text(
                "Pokémons en la región de Kanto",
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
                    hintText: "Buscar pokémon",
                    fillColor: Colors.grey[200],
                    suffixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) async {
                    _debouncer.run(() async  => setState(() {
                      _searchText = value;
                    }));
                  },
                ),
              ),
              Expanded(child: PokemonsListWidget(
                searchText: _searchText,)),
            ],
          ),
        ),
      ),
    );
  }
}
