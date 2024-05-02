import 'package:flutter/material.dart';

class PokedexPage extends StatelessWidget {
  const PokedexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      drawer: MediaQuery.of(context).size.width > 600
          ? const Drawer(
        child: DrawerMenu(),
      )
          : null,
      body: const Center(
        child: Text('¡Bienvenido a tu Pokedex!'),
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width <= 600
          ? BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pokémon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      )
          : null,
    );
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Menú'),
        ),
        ListTile(
          title: const Text('Buscar'),
          onTap: () {
            // TODO: Implementar navegación para buscar
          },
        ),
        ListTile(
          title: const Text('Pokémon'),
          onTap: () {
            // TODO: Implementar navegación para lista de Pokémon
          },
        ),
        ListTile(
          title: const Text('Perfil'),
          onTap: () {
            // TODO: Implementar navegación para perfil
          },
        ),
      ],
    );
  }
}