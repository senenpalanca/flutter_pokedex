import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/styles/colors.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';

class PokemonDetailItem extends StatelessWidget {
  final String title;
  final String value;
  const PokemonDetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: Dimens.textSizeBodySmall,
                color: AppColors.title,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(
           value,
            style: const TextStyle(
                fontSize: Dimens.textSizeBodySmall,
                color: AppColors.subtitle),
          ),
        ],
      ),
    );
  }
}
