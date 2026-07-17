import 'package:hive/hive.dart';
import 'package:saha_bakim/features/field-service/models/work_order_model.dart';

class LocalDatabaseService {
  LocalDatabaseService._privateConstructor();
  static final LocalDatabaseService _instance =
      LocalDatabaseService._privateConstructor();
  factory LocalDatabaseService() => _instance;
  final Box<WorkOrder> _box = Hive.box<WorkOrder>('work_orders_box');

  Future<List<WorkOrder>> getLocalWorkOrders() async {
    return _box.values.toList();
  }

  Future<void> saveWorkOrderToLocal(WorkOrder order) async {
    await _box.put(order.id, order);
  }

  Future<void> addWorkOrderToLocal(WorkOrder order) async {
    await saveWorkOrderToLocal(order);
  }

  Future<void> clearLocalCache() async {
    await _box.clear();
  }
}
