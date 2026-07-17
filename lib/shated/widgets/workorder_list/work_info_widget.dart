import 'package:flutter/material.dart';
import 'package:saha_bakim/shated/widgets/app_text.dart';

class WorkInfoWidget extends StatelessWidget {
  const WorkInfoWidget({super.key, required this.orderlist});

  final List<String> orderlist;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          orderlist.length,
          (index) => AppText(text: orderlist[index]),
        ),
      ),
    );
  }
}
