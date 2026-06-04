import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../logic/primbon_data.dart';

class ItunganChip extends StatelessWidget {
  const ItunganChip({
    super.key,
    required this.number,
    required this.name,
  });

  final int number;
  final String name;

  @override
  Widget build(BuildContext context) {
    final color = colorForItungan(name);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF3A3A3C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$number',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ItunganGrid extends StatelessWidget {
  const ItunganGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 2.8,
      ),
      itemCount: 36,
      itemBuilder: (context, i) {
        final n = i + 1;
        return ItunganChip(number: n, name: itunganAtNumber(n));
      },
    );
  }
}
