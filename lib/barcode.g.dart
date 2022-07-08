// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BarCodeAdapter extends TypeAdapter<BarCode> {
  @override
  final int typeId = 0;

  @override
  BarCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BarCode(
      barCodeValue: fields[0] as String,
      scanDate: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BarCode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.barCodeValue)
      ..writeByte(1)
      ..write(obj.scanDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BarCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
