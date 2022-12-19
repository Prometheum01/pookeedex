// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nature.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NatureAdapter extends TypeAdapter<Nature> {
  @override
  final int typeId = 8;

  @override
  Nature read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Nature(
      name: fields[0] as String,
      natureColor: fields[1] as NatureColor,
      iconPath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Nature obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.natureColor)
      ..writeByte(2)
      ..write(obj.iconPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NatureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
