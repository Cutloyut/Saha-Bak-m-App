import 'package:flutter/material.dart';
import '../../../index.dart';

class WorkAdd extends StatefulWidget {
  const WorkAdd({super.key});

  @override
  State<WorkAdd> createState() => _WorkAddState();
}

class _WorkAddState extends State<WorkAdd> {
  final titleController = TextEditingController();
  final notesController = TextEditingController();
  final techniciannameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final WorkOrderRepository _repository = WorkOrderRepository();

  Future<void> _updateOrderTechnician(
    String title,
    String technician,
    String note,
    BuildContext context,
  ) async {
    try {
      WorkOrder newWorkOrder = WorkOrder(
        id: DateTime.now().microsecondsSinceEpoch,
        title: title,
        status: WorkOrderStatus.open,
        assignmentTechnician: technician,
        expectedQrCode: "qe-00000",
        notes: note,
        photos: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isQrVerified: false,
      );

      await _repository.addWorkOrder(newWorkOrder);
    } catch (e) {
      debugPrint("🚨 Kaydetme esnasında hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(TranslateString('work_adds').tr)),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Column(
            children: [
              TextFormField(
                validator: appvalidator,
                controller: titleController,
                decoration: InputDecoration(hintText: "Arıza/Bakım Adı"),
              ),
              TextFormField(
                validator: appvalidator,
                controller: techniciannameController,
                decoration: InputDecoration(hintText: "Teknisyen Adı"),
              ),
              TextFormField(
                validator: appvalidator,
                controller: notesController,
                maxLines: 4,
                decoration: InputDecoration(hintText: "Teknisyen Adı"),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _updateOrderTechnician(
                        titleController.text,
                        techniciannameController.text,
                        notesController.text,
                        context,
                      );
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("İşlem Başarılı")));
                    }
                  },
                  child: Text(TranslateString('saved').tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: strict_top_level_inference
  String? appvalidator(value) {
    if (value == null || value.isEmpty) {
      return "Bu Kısım Boş Olamaz";
    }
    return null;
  }
}
