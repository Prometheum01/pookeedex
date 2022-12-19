// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonAdapter extends TypeAdapter<Pokemon> {
  @override
  final int typeId = 10;

  @override
  Pokemon read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pokemon(
      id: fields[0] as int,
      name: fields[1] as String,
      image: fields[2] as String,
      abilities: (fields[3] as List).cast<Ability>(),
      stats: (fields[4] as List).cast<Stat>(),
      types: (fields[5] as List).cast<PokemonType>(),
      breeding: fields[7] as Breeding,
      capture: fields[8] as Capture,
      evolve: fields[9] as Evolve,
      moves: (fields[6] as List?)?.cast<Move>(),
    );
  }

  @override
  void write(BinaryWriter writer, Pokemon obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.abilities)
      ..writeByte(4)
      ..write(obj.stats)
      ..writeByte(5)
      ..write(obj.types)
      ..writeByte(6)
      ..write(obj.moves)
      ..writeByte(7)
      ..write(obj.breeding)
      ..writeByte(8)
      ..write(obj.capture)
      ..writeByte(9)
      ..write(obj.evolve);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
