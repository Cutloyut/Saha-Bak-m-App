import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TranslationService.load();
  await Hive.initFlutter();
  Hive.registerAdapter(WorkOrderStatusAdapter());
  Hive.registerAdapter(WorkOrderAdapter());
  await Hive.openBox<WorkOrder>('work_orders_box');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => AppTheme()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = context.watch<AppTheme>();
    return MaterialApp.router(
      title: "app_title".tr,
      theme: themeprovider.lightMode,
      darkTheme: themeprovider.darkMode,
      themeMode: themeprovider.themeMode,
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
  }
}
