// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_lib.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibAdapter extends TypeAdapter<Lib> {
  @override
  final int typeId = 0;

  @override
  Lib read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Lib(
      imageLink: fields[1] as String,
      title: fields[2] as String,
      authors: fields[3] as String,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, Lib obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imageLink)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.authors);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is LibAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}