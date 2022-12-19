// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nature_color.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NatureColorAdapter extends TypeAdapter<NatureColor> {
  @override
  final int typeId = 7;

  @override
  NatureColor read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NatureColor(
      firstColor: fields[0] as Color,
      secondColor: fields[1] as Color,
      shadowColor: fields[2] as Color,
    );
  }

  @override
  void write(BinaryWriter writer, NatureColor obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.firstColor)
      ..writeByte(1)
      ..write(obj.secondColor)
      ..writeByte(2)
      ..write(obj.shadowColor);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NatureColorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
