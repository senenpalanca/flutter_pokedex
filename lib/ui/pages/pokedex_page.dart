import 'package:flutter/material.dart';
import 'package:flutter_pokedex/ui/widgets/drawer/drawer_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      drawer: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
          ? const Drawer(
              child: DrawerMenu(),
            )
          : null,
      body: const Center(
        child: Text('¡Bienvenido a tu Pokedex!'),
      ),
      bottomNavigationBar: ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
          ? BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Pokedex',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pets),
                  label: 'Capturados',
                ),
              ],
            )
          : null,
    );
  }
}

