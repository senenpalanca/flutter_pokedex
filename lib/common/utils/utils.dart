import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/globals/globals.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

/// Returns the pokemon related color given a type
///
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

initFactories() async {
  await Hive.initFlutter();
  await pokemonsFactory.init();
  print('[Utils] - Init factories completed');
}

closeFactories() async {
  await pokemonsFactory.finish();
  print('[Utils] - Close factories completed');
}
