import 'package:hive/hive.dart';

part 'work_order_model.g.dart';

@HiveType(typeId: 0)
enum WorkOrderStatus {
  @HiveField(0)
  open,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  completed,
  @HiveField(3)
  cancelled,
}

@HiveType(typeId: 1)
class WorkOrder extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String assignmentTechnician;

  @HiveField(3)
  final WorkOrderStatus status;

  @HiveField(4)
  final String expectedQrCode;

  @HiveField(5)
  final String notes;

  @HiveField(6)
  final String photos;

  @HiveField(7)
  final DateTime createdAt;

  @HiveField(8)
  final DateTime updatedAt;

  @HiveField(9)
  final bool isQrVerified;

  WorkOrder({
    required this.id,
    required this.title,
    required this.assignmentTechnician,
    required this.status,
    required this.expectedQrCode,
    required this.notes,
    required this.isQrVerified,
    required this.photos,
    required this.createdAt,
    required this.updatedAt,
  });
  WorkOrder copyWith({
    int? id,
    String? title,
    String? assignmentTechnician,
    WorkOrderStatus? status,
    String? expectedQrCode,
    String? notes,
    String? photos,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isQrVerified,
  }) {
    return WorkOrder(
      id: id ?? this.id,
      title: title ?? this.title,
      assignmentTechnician: assignmentTechnician ?? this.assignmentTechnician,
      status: status ?? this.status,
      expectedQrCode: expectedQrCode ?? this.expectedQrCode,
      notes: notes ?? this.notes,
      photos: photos ?? this.photos,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isQrVerified: isQrVerified ?? this.isQrVerified,
    );
  }
}
