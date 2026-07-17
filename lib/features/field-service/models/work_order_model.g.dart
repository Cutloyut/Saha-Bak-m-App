// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOrderAdapter extends TypeAdapter<WorkOrder> {
  @override
  final int typeId = 1;

  @override
  WorkOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOrder(
      id: fields[0] as int,
      title: fields[1] as String,
      assignmentTechnician: fields[2] as String,
      status: fields[3] as WorkOrderStatus,
      expectedQrCode: fields[4] as String,
      notes: fields[5] as String,
      isQrVerified: fields[9] as bool,
      photos: fields[6] as String,
      createdAt: fields[7] as DateTime,
      updatedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOrder obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.assignmentTechnician)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.expectedQrCode)
      ..writeByte(5)
      ..write(obj.notes)
      ..writeByte(6)
      ..write(obj.photos)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.isQrVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkOrderStatusAdapter extends TypeAdapter<WorkOrderStatus> {
  @override
  final int typeId = 0;

  @override
  WorkOrderStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return WorkOrderStatus.open;
      case 1:
        return WorkOrderStatus.inProgress;
      case 2:
        return WorkOrderStatus.completed;
      case 3:
        return WorkOrderStatus.cancelled;
      default:
        return WorkOrderStatus.open;
    }
  }

  @override
  void write(BinaryWriter writer, WorkOrderStatus obj) {
    switch (obj) {
      case WorkOrderStatus.open:
        writer.writeByte(0);
        break;
      case WorkOrderStatus.inProgress:
        writer.writeByte(1);
        break;
      case WorkOrderStatus.completed:
        writer.writeByte(2);
        break;
      case WorkOrderStatus.cancelled:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
