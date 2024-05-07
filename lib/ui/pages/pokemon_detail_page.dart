import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/extensions/extensions.dart';
import 'package:flutter_pokedex/common/globals/globals.dart';
import 'package:flutter_pokedex/common/styles/colors.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';
import 'package:flutter_pokedex/common/utils/utils.dart';
import 'package:flutter_pokedex/ui/widgets/pokemon_details/pokemon_detail_item.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemon_type_card.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PokemonArguments {
  final Pokemon pokemon;
  final bool captured;
  PokemonArguments(this.pokemon, this.captured);
}

class PokemonDetailPage extends StatefulWidget {
  final PokemonArguments pokemonArgs;
  const PokemonDetailPage({super.key, required this.pokemonArgs});

  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  bool _captured = false;
  bool _isLoading = true;

  @override
  void initState() {
    _getCaptured();
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }

  _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius:
                  ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                      : null,
              color: getColorType(
                      widget.pokemonArgs.pokemon.types?.first.type?.name ?? "")!
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
                  child: Image.network(
                    widget.pokemonArgs.pokemon.sprites?.frontDefault ?? "",
                    width: 160,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                    )),
                //ID In bottom left
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "#${widget.pokemonArgs.pokemon.id} ${widget.pokemonArgs.pokemon.name?.capitalize()}",
                  style: const TextStyle(
                      fontSize: Dimens.textSizeBigTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title)),

              Row(
                children: [
                  for (var type in widget.pokemonArgs.pokemon.types!)
                    PokemonTypeCard(
                      type: type,
                    )
                ],
              ),

              const SizedBox(
                height: 12,
              ),
              PokemonDetailItem(
                  title: "Altura",
                  value:
                      "${widget.pokemonArgs.pokemon.height.toString()} unidades"),
              PokemonDetailItem(
                  title: "Peso",
                  value:
                      "${widget.pokemonArgs.pokemon.weight.toString()} unidades"),
              //All the properties of the pokemon
              for (var stat in widget.pokemonArgs.pokemon.stats!)
                PokemonDetailItem(
                    title: stat.stat?.name?.capitalize() ?? "",
                    value: "${stat.baseStat.toString()} puntos"),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 _isLoading ? CircularProgressIndicator() : TextButton(
                      onPressed: onClickCaptureButton,
                      child: Text(_captured ? "Liberar" : "Capturar")),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  onClickCaptureButton() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    if (_captured) {
      pokemonsFactory.releasePokemon(widget.pokemonArgs.pokemon.id!);
      showSnackbar(context, "Pokemon liberado");
      setState(() {
        _captured = false;
      });
    } else {
      pokemonsFactory.capturePokemon(widget.pokemonArgs.pokemon.id!);
      showSnackbar(context, "Pokemon capturado");
      setState(() {
        _captured = true;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _getCaptured() {
    _captured =
        pokemonsFactory.isPokemonCaptured(widget.pokemonArgs.pokemon.id!);
    setState(() {
      _isLoading = false;
    });
  }
}
