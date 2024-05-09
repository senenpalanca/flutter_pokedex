// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_wrapper.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonWrapperAdapter extends TypeAdapter<PokemonWrapper> {
  @override
  final int typeId = 1;

  @override
  PokemonWrapper read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonWrapper(
      serializedPokemon: fields[0] as String,
      captured: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonWrapper obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.serializedPokemon)
      ..writeByte(1)
      ..write(obj.captured);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonWrapperAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
