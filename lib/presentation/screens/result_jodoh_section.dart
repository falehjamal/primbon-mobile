import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../logic/primbon_calculator.dart';
import '../widgets/weton_card.dart';

class ResultJodohSection extends StatelessWidget {
  const ResultJodohSection({super.key, required this.hasil});

  final JodohResult hasil;

  @override
  Widget build(BuildContext context) {
    final accent = colorForItungan(hasil.nama);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              hasil.nama,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: accent,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              hasil.deskripsi,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                WetonCard(label: 'Lanang', weton: hasil.lanang),
                const SizedBox(width: 12),
                WetonCard(label: 'Wedok', weton: hasil.wedok),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Total Neptu: ${hasil.totalNeptu}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
