import 'package:saha_bakim/features/field-service/models/work_order_model.dart';

class MockApiService {
  MockApiService._privateConstructor();
  static final MockApiService _instance = MockApiService._privateConstructor();

  factory MockApiService() {
    return _instance;
  }

  final List<WorkOrder> _cloudDatabase = [
    WorkOrder(
      id: 101,
      title: "Klima Kompresör Arızası",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.open,
      expectedQrCode: "QR-AC-300",
      notes: "",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 102,
      title: "Asansör Periyodik Bakımı",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.inProgress,
      expectedQrCode: "QR-ELEV-99",
      notes: "Teknisyen sahaya ulaştı, inceleme başladı.",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(days: 145)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 4)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 103,
      title: "Jeneratör Yağ Sızıntısı",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.cancelled,
      expectedQrCode: "QR-GEN-55",
      notes: "",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 104,
      title: "Kazan Dairesi Basınç Valfi Değişimi",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.open,
      expectedQrCode: "QR-BOILER-22",
      notes:
          "Kazan dairesindeki 2 numaralı emniyet ventilinde sızdırmazlık kaybı var, yenisiyle değiştirilecek.",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(hours: 12)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 105,
      title: "Yemekhane Havalandırma Fanı Bakımı",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.inProgress,
      expectedQrCode: "QR-VENT-FOOD",
      notes:
          "Fan kayışında gevşeme ve motorda aşırı ses tespiti yapıldı. Kayış gerginliği ayarlanıyor.",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 106,
      title: "B Blok Ana Dağıtım Panosu Termal Kamera Kontrolü",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.completed,
      expectedQrCode: "QR-PANEL-B",
      notes:
          "Tüm şalterler termal kamerayla tarandı, aşırı ısınan klemensler sıkılarak gevşeklik giderildi.",
      photos: "assets/images/panel_thermal.jpg",
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      isQrVerified: true,
    ),
    WorkOrder(
      id: 107,
      title: "Bahçe Aydınlatma Armatürlerinin Revizyonu",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.open,
      expectedQrCode: "QR-LIGHT-GARDEN",
      notes:
          "Arka bahçedeki 4 adet LED projektörün su alması sebebiyle sigorta attırıyor. Kasalar kurutulup izole edilecek.",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 108,
      title: "Su Deposu Hidrofor Kart Değişimi",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.cancelled,
      expectedQrCode: "QR-PUMP-WATER",
      notes:
          "Ana kartta yanık tespit edildi. Yeni kart siparişi onaylanmadığı için iş emri iptal edildi.",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      updatedAt: DateTime.now().subtract(const Duration(days: 9)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 109,
      title: "A Blok Yangın Çıkış Kapıları Kilit Kontrolü",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.completed,
      expectedQrCode: "QR-FIRE-DOOR-A",
      notes:
          "Panik barların tamamı yağlandı, sıkışan kapı hidrolikleri ayarlanarak çalışır duruma getirildi.",
      photos: "assets/images/fire_door.jpg",
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      updatedAt: DateTime.now().subtract(const Duration(days: 4)),
      isQrVerified: true,
    ),
    WorkOrder(
      id: 110,
      title: "Arıtma Tesisi Dozaj Pompası Kalibrasyonu",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.inProgress,
      expectedQrCode: "QR-TREAT-PUMP",
      notes:
          "Klor dozajlama pompasının debi ölçümü yapılıyor. Kimyasal tank seviyeleri kontrol ediliyor.",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 1)),
      isQrVerified: false,
    ),
    WorkOrder(
      id: 111,
      title: "Server Odası Hassas Klima Gaz Şarjı",
      assignmentTechnician: "eren dikbıyık",
      status: WorkOrderStatus.open,
      expectedQrCode: "QR-SERVER-AC-01",
      notes:
          "Sistem odası klimasında düşük basınç alarmı var. R410A gaz şarjı yapılacak ve sızıntı testi uygulanacak.",
      photos: "",
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      isQrVerified: false,
    ),
  ];

  Future<List<WorkOrder>> fetchWorkOrdersFromServer() async {
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_cloudDatabase);
  }

  Future<bool> updateWorkOrderOnServer(WorkOrder updatedOrder) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _cloudDatabase.indexWhere(
      (item) => item.id == updatedOrder.id,
    );

    if (index != -1) {
      _cloudDatabase[index] = updatedOrder;
      return true;
    }
    return false;
  }

  Future<WorkOrder> addWorkOrderOnServer(WorkOrder newOrder) async {
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Ağ gecikmesi simülasyonu

    final int newId = _cloudDatabase.isEmpty
        ? 101
        : _cloudDatabase.map((e) => e.id).reduce((a, b) => a > b ? a : b) + 1;

    final createdOrder = WorkOrder(
      id: newId,
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

    _cloudDatabase.add(createdOrder);
    return createdOrder;
  }
}
