part of 'colors_bloc.dart';

@immutable
sealed class ColorsEvent {}

final class ColorsInitialEvent extends ColorsEvent {}

final class ChangeColorEvent extends ColorsEvent {
  ChangeColorEvent();
}