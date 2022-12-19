// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaptureAdapter extends TypeAdapter<Capture> {
  @override
  final int typeId = 2;

  @override
  Capture read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Capture(
      habitat: fields[0] as String,
      generation: fields[1] as String,
      captureRate: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Capture obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.habitat)
      ..writeByte(1)
      ..write(obj.generation)
      ..writeByte(2)
      ..write(obj.captureRate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaptureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
