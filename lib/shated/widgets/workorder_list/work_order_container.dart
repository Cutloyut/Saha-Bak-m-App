import 'package:flutter/material.dart';

class WorkOrderContainer extends StatelessWidget {
  const WorkOrderContainer({
    super.key,
    required this.workTitle,
    required this.color,
  });
  final Color color;
  final String workTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        border: BoxBorder.fromLTRB(
          bottom: BorderSide(color: Colors.black, width: 1.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
        child: Text(workTitle),
      ),
    );
  }
}
