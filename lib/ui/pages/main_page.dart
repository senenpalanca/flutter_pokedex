import 'package:flutter/material.dart';
import 'package:flutter_pokedex/ui/pages/captured_page.dart';
import 'package:flutter_pokedex/ui/pages/pokedex_page.dart';
import 'package:flutter_pokedex/ui/widgets/drawer/drawer_menu.dart';
import 'package:responsive_framework/responsive_framework.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
          ? Drawer(
              elevation: 0,
              shape:
                  const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: DrawerMenu(
                onTabSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;
                  });
                },
              ),
            )
          : null,
      body: _buildBody(),
      bottomNavigationBar:
          ResponsiveBreakpoints.of(context).smallerOrEqualTo(MOBILE)
              ? BottomNavigationBar(
            selectedItemColor:                    Theme.of(context).primaryColor,

                  currentIndex: _selectedTabIndex,
                  onTap: (index) {
                    setState(() {
                      _selectedTabIndex = index;
                    });
                  },
                  items:  <BottomNavigationBarItem>[
                    BottomNavigationBarItem(

                      icon: Icon(Icons.search,),
                      label: 'Pokédex',
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

  _buildBody() {
    return IndexedStack(
      index: _selectedTabIndex,
      children: const [
        PokedexPage(),
        CapturedPage(),
      ],
    );
  }
}
