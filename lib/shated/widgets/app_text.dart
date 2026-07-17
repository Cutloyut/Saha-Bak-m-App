import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  const AppText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 12),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: true,
    );
  }
}
