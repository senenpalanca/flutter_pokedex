import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter_pokedex/common/globals/globals.dart';
import 'package:meta/meta.dart';

part 'colors_event.dart';
part 'colors_state.dart';

class ColorsBloc extends Bloc<ColorsEvent, ColorsState> {
  ColorsBloc() : super(ColorsInitial()) {
    on<ChangeColorEvent>((event, emit) async {
      Color predominantColor = await pokemonsFactory.getPredominantColor();
      emit(ColorsChangedState(color: predominantColor));
    });
  }
}
