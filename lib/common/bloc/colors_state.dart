part of 'colors_bloc.dart';

@immutable
sealed class ColorsState {
  final Color? color;

  const ColorsState._({this.color});
}

final class ColorsInitial extends ColorsState {
  const ColorsInitial() : super._();
}

final class ColorsChangedState extends ColorsState {
  const ColorsChangedState({required Color color}) : super._(color: color);
}