import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:saha_bakim/core/utils/filter_status_extentions.dart';
import 'package:saha_bakim/features/field-service/data/work_order_repository.dart';
import 'package:saha_bakim/features/field-service/models/app_user_model.dart';
import 'package:saha_bakim/features/field-service/models/work_order_model.dart';

enum FilterStatusEnum { all, open, inProgress, completed, cancelled, nulls }

class FilterProvider extends ChangeNotifier {
  FilterStatusEnum? _filterStatus;
  FilterStatusEnum get filterStatus => _filterStatus ?? FilterStatusEnum.all;
  int? _filterTime;
  int get filterTime => _filterTime ?? 0;
  String? _searchQuery;
  String get searchQuery => _searchQuery ?? "";
  bool isLoading = false;
  void statusregen(FilterStatusEnum status) {
    _filterStatus = status;
    notifyListeners();
  }

  void timeregen(int time) {
    _filterTime = time;
    notifyListeners();
  }

  void serachRegen(String text) {
    _searchQuery = text;
    notifyListeners();
  }

  List<WorkOrder> getFilteredWorkOrders(
    List<WorkOrder> workOrderListAll,
    AppUser currentUserRole,
  ) {
    List<WorkOrder> tempOrders = List.from(workOrderListAll);

    if (currentUserRole.role == UserRole.technician) {
      tempOrders = tempOrders
          .where(
            (order) =>
                order.status != WorkOrderStatus.cancelled &&
                order.assignmentTechnician.toLowerCase() ==
                    currentUserRole.name.toLowerCase(),
          )
          .toList();
    }

    if (filterStatus != FilterStatusEnum.all) {
      tempOrders = tempOrders.where((order) {
        return order.status.name == filterStatus.name;
      }).toList();
    }

    if (filterTime != 0) {
      final now = DateTime.now();
      final thirtyDaysAgo = now.subtract(Duration(days: filterTime));
      tempOrders = tempOrders.where((order) {
        return order.createdAt.isAfter(thirtyDaysAgo);
      }).toList();
    }

    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.toLowerCase().trim();
      tempOrders = tempOrders.where((order) {
        final matchesTitle = order.title.toLowerCase().contains(query);
        final matchesNotes = order.notes.toLowerCase().contains(query);

        return matchesTitle || matchesNotes;
      }).toList();
    }

    // 5. Denetim Günlüğü (Audit Log)
    log(
      "Kullanıcı:${currentUserRole.name}, ${DateTime.now()} Tarihinde ${filterStatus.trName} İşleri Listeledi. Arama Kelimesi: '$searchQuery'",
      name: "Audit Log",
    );

    return tempOrders;
  }

  final WorkOrderRepository _repository = WorkOrderRepository();

  List<WorkOrder> orders = [];
  Future<void> loadWorkOrders() async {
    isLoading = true;
    notifyListeners();
    try {
      final orderss = await _repository.getWorkOrders();

      orders = orderss;
    } catch (e) {
      debugPrint("İşler yüklenirken hata: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
