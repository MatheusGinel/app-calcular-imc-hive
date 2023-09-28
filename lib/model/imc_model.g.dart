// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imc_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IMCModelAdapter extends TypeAdapter<IMCModel> {
  @override
  final int typeId = 0;

  @override
  IMCModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IMCModel()
      .._peso = fields[0] as double
      .._altura = fields[1] as double
      .._resultado = fields[2] as double;
  }

  @override
  void write(BinaryWriter writer, IMCModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj._peso)
      ..writeByte(1)
      ..write(obj._altura)
      ..writeByte(2)
      ..write(obj._resultado);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IMCModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
