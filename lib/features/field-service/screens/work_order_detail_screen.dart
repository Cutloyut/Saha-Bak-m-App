// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../index.dart';

class WorkOrderDetailScreen extends StatefulWidget {
  const WorkOrderDetailScreen({
    super.key,
    required this.workorder,
    required this.repository,
  });
  final WorkOrder workorder;
  final WorkOrderRepository repository;

  @override
  State<WorkOrderDetailScreen> createState() => _WorkOrderDetailScreenState();
}

class _WorkOrderDetailScreenState extends State<WorkOrderDetailScreen> {
  late WorkOrder _currentOrder;
  late final notesController = TextEditingController(text: _currentOrder.notes);
  late final nameController = TextEditingController(
    text: _currentOrder.assignmentTechnician,
  );

  @override
  void initState() {
    super.initState();
    _currentOrder = widget.workorder;
  }

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

  Future<void> _handleQrVerification(BuildContext context) async {
    final String? scannedCode = await context.push<String>(
      '/qr-scanner-screen',
    );
    if (scannedCode == null) return;

    WorkOrder updatedOrder = _currentOrder.copyWith(isQrVerified: true);

    await widget.repository.updateWorkOrder(updatedOrder);
    setState(() {
      _currentOrder = updatedOrder; // Ekranı güncelliyoruz
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('equipment_verified'.tr)));
  }

  Future<void> _updateOrderStatus(WorkOrderStatus newStatus) async {
    WorkOrder updatedOrder = _currentOrder.copyWith(
      status: newStatus,
      updatedAt: DateTime.now(),
    );

    await widget.repository.updateWorkOrder(updatedOrder);
    setState(() {
      _currentOrder = updatedOrder;
    });
  }

  Future<void> _updateOrderStatusCancelled(WorkOrderStatus newStatus) async {
    WorkOrder updatedOrder = _currentOrder.copyWith(
      status: newStatus,
      isQrVerified: false,

      updatedAt: DateTime.now(),
    );

    await widget.repository.updateWorkOrder(updatedOrder);
    setState(() {
      _currentOrder = updatedOrder;
    });
  }

  Future<void> _updateOrderTechnician(String technician) async {
    WorkOrder updatedOrder = _currentOrder.copyWith(
      assignmentTechnician: technician,
      updatedAt: DateTime.now(),
    );

    await widget.repository.updateWorkOrder(updatedOrder);
    setState(() {
      _currentOrder = updatedOrder;
    });
  }

  String _getButtonText() {
    if (!_currentOrder.isQrVerified) {
      return "QR Kodunu Tara";
    }
    switch (_currentOrder.status) {
      case WorkOrderStatus.open:
        return "work_start".tr;
      case WorkOrderStatus.inProgress:
        return "complated_is_work".tr;
      case WorkOrderStatus.completed:
        return "work_complated".tr;
      case WorkOrderStatus.cancelled:
        return "work_cancelled".tr;
    }
  }

  Future<void>? _flowButtonFunctoin() async {
    if (!_currentOrder.isQrVerified) {
      await _handleQrVerification(context);
    } else if (_currentOrder.status == WorkOrderStatus.open) {
      await _updateOrderStatus(WorkOrderStatus.inProgress);
    } else if (_currentOrder.status == WorkOrderStatus.inProgress) {
      await _pickImage();
      await _updateOrderStatus(WorkOrderStatus.completed);
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );

    if (image != null) {
      String filePath = image.path;
      String updatedPhotos = filePath;

      WorkOrder updatedOrder = _currentOrder.copyWith(
        photos: updatedPhotos,
        updatedAt: DateTime.now(),
      );
      await widget.repository.updateWorkOrder(updatedOrder);
      setState(() {
        _currentOrder = updatedOrder;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('pickeradd'.tr)));
    }
  }

  void _noteSaved() async {
    WorkOrder updatedOrder = _currentOrder.copyWith(
      notes: notesController.text,
    );
    await widget.repository.updateWorkOrder(updatedOrder);

    setState(() {
      _currentOrder = updatedOrder;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('noteadd'.tr)));
  }

  final List<String> workordertext = [
    "start_date".tr,
    "update_date".tr,
    "qr_verified".tr,
    "stage".tr,
    "qr_kod".tr,
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text("workdetalis".tr),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        leading: IconButton(
          onPressed: () => context.push('/work-order-list-screen'),
          icon: Icon(Icons.arrow_back),
        ),

        actions: [
          authProvider.currentUser?.role == UserRole.teamlead
              ? Row(
                  children: [
                    Text("changestate".tr),
                    IconButton(
                      onPressed: () => _cancelledStatus(),
                      icon: _currentOrder.status.statusicon,
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(3),
        child: Card(
          shape: Theme.of(context).cardTheme.shape,
          child: Column(
            children: [
              authProvider.currentUser!.role == UserRole.teamlead
                  ? TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'Atama Yapmak İçinTeknisyen Adını Giriniz',
                        icon: IconButton(
                          onPressed: () =>
                              _updateOrderTechnician(nameController.text),
                          icon: Icon(Icons.check),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              WorkOrderContainer(
                workTitle: _currentOrder.title,
                color: _currentOrder.status.statusColor,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      children: [
                        WorkInfoWidget(orderlist: workordertext),
                        WorkInfoWidget(
                          orderlist: [
                            DateFormat(
                              'dd/MM/yyyy HH:mm:ss',
                            ).format(_currentOrder.createdAt),

                            DateFormat(
                              'dd/MM/yyyy HH:mm:ss',
                            ).format(_currentOrder.updatedAt),

                            _currentOrder.isQrVerified
                                ? "Onaylandı"
                                : "Onay Bekliyor",

                            _currentOrder.status.trName,
                            _currentOrder.expectedQrCode,
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _flowButtonFunctoin,
                        child: Text(_getButtonText()),
                      ),
                    ),
                    TextField(
                      controller: notesController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Notunuz',
                        suffixIcon: IconButton(
                          onPressed: () => _noteSaved(),
                          icon: Icon(Icons.save),
                        ),
                      ),
                    ),
                    _currentOrder.photos != ""
                        ? SizedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(_currentOrder.photos),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _cancelledStatus() {
    _updateOrderStatusCancelled(
      _currentOrder.status == WorkOrderStatus.cancelled
          ? WorkOrderStatus.open
          : WorkOrderStatus.cancelled,
    );
    setState(() {});
  }
}
