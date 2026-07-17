import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:light_dark_theme_toggle/light_dark_theme_toggle.dart';
import 'package:provider/provider.dart';
import '../../../index.dart';

class WorkOrderListScreen extends StatefulWidget {
  const WorkOrderListScreen({super.key});

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();
}

class _WorkOrderListScreenState extends State<WorkOrderListScreen> {
  final searchController = TextEditingController();
  final timeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FilterProvider>().loadWorkOrders();
    });
  }

  @override
  void dispose() {
    timeController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await context.read<FilterProvider>().loadWorkOrders();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<AppTheme>();
    final authProvider = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslateString("work_list").tr),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        automaticallyImplyLeading: false,
        actions: [
          LightDarkThemeToggle(
            value: themeProvider.isDarkMode,
            onChanged: (value) => themeProvider.toggleTheme(),
          ),
          authProvider.currentUser!.role == UserRole.teamlead
              ? IconButton(
                  onPressed: () async {
                    final result = await context.push('/work_add');
                    if (result == true) {
                      _refreshData();
                    }
                  },
                  icon: const Icon(Icons.add),
                )
              : const SizedBox.shrink(),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: FilterSegmentedButton(),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) => context.read<FilterProvider>().serachRegen(
              searchController.text,
            ),
            decoration: InputDecoration(hintText: 'Arama'),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: Consumer<FilterProvider>(
                builder: (context, filterProvider, child) {
                  if (filterProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final filteredList = filterProvider.getFilteredWorkOrders(
                    filterProvider.orders,
                    authProvider.currentUser!,
                  );
                  if (filteredList.isEmpty) {
                    return const EmptyState();
                  }
                  return WorkOrderList(orderlist: filteredList);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
