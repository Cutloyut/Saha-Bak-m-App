import 'package:flutter/material.dart';

class AppColorText extends StatelessWidget {
  const AppColorText({super.key, required this.text, required this.color});
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(fontSize: 12, color: color),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: true,
    );
  }
}
