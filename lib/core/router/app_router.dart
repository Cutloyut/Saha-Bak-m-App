import 'package:go_router/go_router.dart';
import '../../index.dart';

class AppRouter {
  static final _repository = WorkOrderRepository();
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/work-order-list-screen',
        builder: (context, state) => WorkOrderListScreen(),
      ),
      GoRoute(
        path: '/qr-scanner-screen',
        builder: (context, state) => QrScannerScreen(),
      ),
      GoRoute(path: '/work_add', builder: (context, state) => WorkAdd()),
      GoRoute(
        path: '/work-order-detalis-screen',
        builder: (context, state) {
          final order = state.extra as WorkOrder;
          return WorkOrderDetailScreen(
            workorder: order,
            repository: _repository,
          );
        },
      ),
    ],
  );
}
