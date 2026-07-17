class AuditLogModel {
  final int id;
  final String workOrderId;
  final String actionType;
  final String description;
  final String userRole;
  final DateTime timestamp;

  AuditLogModel({
    required this.id,
    required this.workOrderId,
    required this.actionType,
    required this.description,
    required this.userRole,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workOrderId': workOrderId,
      'actionType': actionType,
      'description': description,
      'userRole': userRole,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
