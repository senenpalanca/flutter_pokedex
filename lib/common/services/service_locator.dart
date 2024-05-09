import 'package:flutter_pokedex/common/services/pokemon_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services
  if (!locator.isRegistered<PokemonService>())
    locator.registerSingleton<PokemonService>(PokemonService());
}
