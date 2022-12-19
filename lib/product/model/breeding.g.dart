// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breeding.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BreedingAdapter extends TypeAdapter<Breeding> {
  @override
  final int typeId = 1;

  @override
  Breeding read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Breeding(
      eggGroups: (fields[0] as List).cast<EggGroup>(),
      hatchCounter: fields[1] as int,
      genderRate: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Breeding obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.eggGroups)
      ..writeByte(1)
      ..write(obj.hatchCounter)
      ..writeByte(2)
      ..write(obj.genderRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BreedingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
