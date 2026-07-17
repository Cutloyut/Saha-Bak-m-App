import 'package:flutter/material.dart';
import 'package:saha_bakim/features/field-service/models/work_order_model.dart';

extension WorkOrderStatusExtension on WorkOrderStatus {
  String get trName {
    switch (this) {
      case WorkOrderStatus.open:
        return 'Açık';
      case WorkOrderStatus.inProgress:
        return 'Devam Ediyor';
      case WorkOrderStatus.completed:
        return 'Tamamlandı';
      case WorkOrderStatus.cancelled:
        return 'İptal Edildi';
    }
  }

  Color get statusColor {
    switch (this) {
      case WorkOrderStatus.open:
        return Colors.yellow;
      case WorkOrderStatus.inProgress:
        return const Color.fromARGB(255, 11, 111, 193);
      case WorkOrderStatus.completed:
        return Colors.green;
      case WorkOrderStatus.cancelled:
        return Colors.red;
    }
  }

  Icon get statusicon {
    switch (this) {
      case WorkOrderStatus.cancelled:
        return Icon(Icons.check, color: Colors.blue);
      default:
        return Icon(Icons.close, color: Colors.red);
    }
  }
}
