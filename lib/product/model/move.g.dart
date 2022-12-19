// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoveAdapter extends TypeAdapter<Move> {
  @override
  final int typeId = 6;

  @override
  Move read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Move(
      name: fields[0] as String,
      type: fields[1] as PokemonType,
      effectEntries: fields[2] as String,
      accuracy: fields[3] as String,
      basePower: fields[4] as String,
      pp: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Move obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.effectEntries)
      ..writeByte(3)
      ..write(obj.accuracy)
      ..writeByte(4)
      ..write(obj.basePower)
      ..writeByte(5)
      ..write(obj.pp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
