import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/routes/route_service.dart';
import 'package:flutter_pokedex/common/utils/utils.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'common/globals/globals.dart';
import 'common/services/service_locator.dart';

void main() async {
  setupLocator();
  await initFactories();
  runApp(const FlutterPokedex());
}

class FlutterPokedex extends StatefulWidget {
  const FlutterPokedex({super.key});

  @override
  State<FlutterPokedex> createState() => _FlutterPokedexState();
}

class _FlutterPokedexState extends State<FlutterPokedex>  with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Pokédex Code Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, secondary: Colors.deepOrange),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      /// Use onGenerateRoute for Custom Routing/Navigation Animations
      // onGenerateRoute: (settings) => Routes.onGenerateRoute(settings,context),
      initialRoute: RouteServices.STARTING_POINT,
      routes: RouteServices.routes,
      navigatorKey: navigatorKey,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 600, name: MOBILE),
          const Breakpoint(start: 601, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
    );
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

     if (state == AppLifecycleState.detached) {
      closeFactories();
    }
  }
}
