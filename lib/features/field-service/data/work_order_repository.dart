import 'package:saha_bakim/core/services/local_database_service.dart';
import 'package:saha_bakim/core/services/mock_api_service.dart';
import 'package:saha_bakim/features/field-service/models/work_order_model.dart';

class WorkOrderRepository {
  WorkOrderRepository._privateConstructor({
    required MockApiService apiService,
    required LocalDatabaseService localDatabaseService,
    // ignore: prefer_initializing_formals
  }) : _apiService = apiService,
       // ignore: prefer_initializing_formals
       _localDatabaseService = localDatabaseService;

  static final WorkOrderRepository _instance =
      WorkOrderRepository._privateConstructor(
        apiService: MockApiService(),
        localDatabaseService: LocalDatabaseService(),
      );

  factory WorkOrderRepository() => _instance;

  final MockApiService _apiService;
  final LocalDatabaseService _localDatabaseService;

  bool isOnline = true;

  Future<List<WorkOrder>> getWorkOrders() async {
    if (isOnline) {
      try {
        final serverOrders = await _apiService.fetchWorkOrdersFromServer();
        for (var order in serverOrders) {
          await _localDatabaseService.saveWorkOrderToLocal(order);
        }
        return await _localDatabaseService.getLocalWorkOrders();
      } catch (e) {
        return await _localDatabaseService.getLocalWorkOrders();
      }
    } else {
      return await _localDatabaseService.getLocalWorkOrders();
    }
  }

  Future<bool> updateWorkOrder(WorkOrder updatedOrder) async {
    await _localDatabaseService.saveWorkOrderToLocal(updatedOrder);
    if (isOnline) {
      final success = await _apiService.updateWorkOrderOnServer(updatedOrder);
      if (success) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  Future<WorkOrder> addWorkOrder(WorkOrder newOrder) async {
    if (isOnline) {
      try {
        final savedOrder = await _apiService.addWorkOrderOnServer(newOrder);
        await _localDatabaseService.addWorkOrderToLocal(savedOrder);
        return savedOrder;
      } catch (e) {
        return await _saveOffline(newOrder);
      }
    } else {
      return await _saveOffline(newOrder);
    }
  }

  Future<WorkOrder> _saveOffline(WorkOrder newOrder) async {
    final offlineId = DateTime.now().millisecondsSinceEpoch * -1;
    final offlineOrder = WorkOrder(
      id: offlineId,
      title: newOrder.title,
      assignmentTechnician: newOrder.assignmentTechnician,
      status: newOrder.status,
      expectedQrCode: newOrder.expectedQrCode,
      notes: newOrder.notes,
      photos: newOrder.photos,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isQrVerified: false,
    );
    await _localDatabaseService.addWorkOrderToLocal(offlineOrder);
    return offlineOrder;
  }
}
