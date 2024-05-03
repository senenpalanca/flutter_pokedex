import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final Function(int) onTabSelected;

  const DrawerMenu({Key? key, required this.onTabSelected}) : super(key: key);

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
          title: const Text('Pokédex'),
          onTap: () {
            onTabSelected(0);
          },
        ),
        ListTile(
          title: const Text('Capturados'),
          onTap: () {
            onTabSelected(1);
          },
        ),

      ],
    );
  }
}
