import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/styles/colors.dart';
import 'package:flutter_pokedex/common/utils/debouncer.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/captured_pokemons_list_widget.dart';
import 'package:flutter_pokedex/ui/widgets/pokemons_list/pokemons_list_widget.dart';

import '../../common/styles/dimensions.dart';

class CapturedPage extends StatefulWidget {
  const CapturedPage({Key? key}) : super(key: key);

  @override
  State<CapturedPage> createState() => _CapturedPageState();
}

class _CapturedPageState extends State<CapturedPage> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("Pokemons capturados",
                  style: TextStyle(
                      fontSize: Dimens.textSizeBigTitle,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title)),
               Text(
                "Sección del entrenador",
                style: TextStyle(
                    fontSize: Dimens.textSizeBodySmall,
                    color: AppColors.subtitle),
              ),
               SizedBox(
                height: 12,
              ),
               Expanded(child: CapturedPokemonsListWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
