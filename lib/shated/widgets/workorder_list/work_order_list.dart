import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../index.dart';

class WorkOrderList extends StatelessWidget {
  const WorkOrderList({super.key, required this.orderlist});
  final List<WorkOrder> orderlist;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: orderlist.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsetsGeometry.all(3),
          child: GestureDetector(
            onTap: () => context.push(
              '/work-order-detalis-screen',
              extra: orderlist[index],
            ),
            child: Card(
              shape: Theme.of(context).cardTheme.shape,
              child: Column(
                children: [
                  WorkOrderContainer(
                    workTitle: orderlist[index].title,
                    color: orderlist[index].status.statusColor,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            WorkInfoWidget(
                              orderlist: [
                                TranslateString("start_date").tr,
                                TranslateString("stage").tr,
                              ],
                            ),
                            WorkInfoWidget(
                              orderlist: [
                                DateFormat(
                                  'dd/MM/yyyy HH:mm:ss',
                                ).format(orderlist[index].createdAt),
                                orderlist[index].status.trName,
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
