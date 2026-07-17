import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../index.dart';

class FilterSegmentedButton extends StatefulWidget {
  const FilterSegmentedButton({super.key});

  @override
  State<FilterSegmentedButton> createState() => _FilterSegmentedButtonState();
}

class _FilterSegmentedButtonState extends State<FilterSegmentedButton> {
  @override
  Widget build(BuildContext context) {
    final authprovider = context.read<AuthProvider>();
    return Column(
      children: [
        SegmentedButton<FilterStatusEnum>(
          showSelectedIcon: false,
          segments: <ButtonSegment<FilterStatusEnum>>[
            ButtonSegment<FilterStatusEnum>(
              value: FilterStatusEnum.all,
              icon: Icon(Icons.list),
            ),
            ButtonSegment<FilterStatusEnum>(
              value: FilterStatusEnum.open,
              icon: Icon(Icons.lock_open_rounded),
            ),
            ButtonSegment<FilterStatusEnum>(
              value: FilterStatusEnum.inProgress,
              icon: Icon(Icons.cached),
            ),
            ButtonSegment<FilterStatusEnum>(
              value: FilterStatusEnum.completed,
              icon: Icon(Icons.check),
            ),
            authprovider.currentUser!.role == UserRole.teamlead
                ? ButtonSegment<FilterStatusEnum>(
                    value: FilterStatusEnum.cancelled,
                    icon: Icon(Icons.close),
                  )
                : ButtonSegment(value: FilterStatusEnum.nulls, label: Text("")),
          ],
          selected: <FilterStatusEnum>{
            context.watch<FilterProvider>().filterStatus,
          },
          onSelectionChanged: (p0) => setState(() {
            if (p0.first == FilterStatusEnum.nulls) {
            } else {
              context.read<FilterProvider>().statusregen(p0.first);
            }
          }),
        ),
        SegmentedButton<int>(
          showSelectedIcon: false,
          segments: <ButtonSegment<int>>[
            ButtonSegment<int>(value: 0, label: Text("0")),
            ButtonSegment<int>(value: 7, label: Text("7")),
            ButtonSegment<int>(value: 60, label: Text("30")),
            ButtonSegment<int>(value: 120, label: Text("120")),
            ButtonSegment<int>(value: 365, label: Text("365")),
          ],
          selected: <int>{context.watch<FilterProvider>().filterTime},
          onSelectionChanged: (p0) => setState(() {
            context.read<FilterProvider>().timeregen(p0.first);
          }),
        ),
      ],
    );
  }
}
