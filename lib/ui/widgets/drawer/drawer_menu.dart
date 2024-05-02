import 'package:flutter/material.dart';

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
          title: const Text('Pokédex'),
          onTap: () {
          },
        ),
        ListTile(
          title: const Text('Capturados'),
          onTap: () {
          },
        ),

      ],
    );
  }
}
