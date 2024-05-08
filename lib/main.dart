import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/bloc/colors_bloc.dart';
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

class _FlutterPokedexState extends State<FlutterPokedex>
    with WidgetsBindingObserver {

  @override
  void initState() {
    //BlocProvider.of<ColorsBloc>(context).add(ChangeColorEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ColorsBloc(),
      child: BlocBuilder<ColorsBloc, ColorsState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Pokédex Code Challenge',
            theme: ThemeData(
             primaryColor: state.color ?? const Color(0XFFcc0000),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: RouteServices.STARTING_POINT,
            routes: RouteServices.routes,
            navigatorKey: navigatorKey,
            builder: (context, child) =>
                ResponsiveBreakpoints.builder(
                  child: child!,
                  breakpoints: [
                    const Breakpoint(start: 0, end: 600, name: MOBILE),
                    const Breakpoint(start: 601, end: 800, name: TABLET),
                    const Breakpoint(start: 801, end: 1000, name: DESKTOP),
                    const Breakpoint(start: 801, end: 1920, name: BIG_DESKTOP),
                    const Breakpoint(
                        start: 1921, end: double.infinity, name: '4K'),
                  ],
                ),
          );
        },
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
