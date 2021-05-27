// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gif.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GIFAdapter extends TypeAdapter<GIF> {
  @override
  final int typeId = 0;

  @override
  GIF read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GIF(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GIF obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.width)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GIFAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
