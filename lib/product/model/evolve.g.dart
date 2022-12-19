// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evolve.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EvolveAdapter extends TypeAdapter<Evolve> {
  @override
  final int typeId = 4;

  @override
  Evolve read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Evolve(
      name: fields[0] as String,
      evolvesTo: fields[1] as Evolve?,
      image: fields[3] as String,
      evolveLevel: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Evolve obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.evolvesTo)
      ..writeByte(2)
      ..write(obj.evolveLevel)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EvolveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
