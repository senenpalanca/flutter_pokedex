import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/styles/dimensions.dart';

class DrawerMenu extends StatelessWidget {
  final Function(int) onTabSelected;

  const DrawerMenu({Key? key, required this.onTabSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset("assets/images/trainer.png")),
              const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 30.0),
                    child: Text('Menú',
                        style: TextStyle(
                            fontSize: Dimens.textSizeBigTitle,
                            color: Colors.white)),
                  )),
            ],
          ),
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
