import 'package:flutter/material.dart';
import 'package:flutter_pokedex/ui/pages/captured_page.dart';
import 'package:flutter_pokedex/ui/pages/main_page.dart';
import 'package:flutter_pokedex/ui/pages/pokemon_detail_page.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';


///
/// define all of your application routes here!!
///
abstract class Routes {

  static const INITIAL = '/initial';
  static const POKEMON_DETAIL_PAGE = '/pokemon_detail_page';
  static const CAPTURED_POKEMON_PAGE = '/captured_pokemon_page';
}

///
/// define all of your route services here!!
///
abstract class RouteServices {
  const RouteServices._();

  ///STARTING ROUTE OF APPLICATION
  static const STARTING_POINT = Routes.INITIAL;

  ///--> Add your application routes here!
  static Map<String, Widget Function(BuildContext context)> routes = {
    Routes.INITIAL: (context) => const MainPage(),
    //Create a detail page with arguments
    Routes.POKEMON_DETAIL_PAGE: (context) => PokemonDetailPage(pokemonArgs: ModalRoute.of(context)!.settings.arguments as PokemonArguments),
    Routes.CAPTURED_POKEMON_PAGE: (context) => CapturedPage(),
  };

  ///  add routing animation here!!
  static PageRoute onGenerateRoute(settings, context) {
    /// Custom Route Animations for Custom Pages
    // if (settings.name == "/someRoute") {
    //   return PageRouteBuilder(
    //       settings: settings, // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
    //       pageBuilder: (_, __, ___) => Routes.routes[settings.name]!(context),
    //       transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c));
    // }
    return MaterialPageRoute(
        builder: (_) => RouteServices.routes[settings.name]!(context));
  }
}
