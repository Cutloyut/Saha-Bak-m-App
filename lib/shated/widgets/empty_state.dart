import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("notfound".tr));
  }
}
