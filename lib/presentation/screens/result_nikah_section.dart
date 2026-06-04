import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../logic/primbon_calculator.dart';

class ResultNikahSection extends StatelessWidget {
  const ResultNikahSection({super.key, required this.hasil});

  final NikahRecommendation hasil;

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('EEEE, d MMMM yyyy', 'id_ID');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Rekomendasi Hari Nikah',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Total Neptu: ${hasil.totalNeptu}\n'
              'Angka Target (mod 3 = 2): ${hasil.angkaTarget}\n'
              'Neptu Hari Nikah: ${hasil.angkaTarget} - ${hasil.totalNeptu} = ${hasil.neptuHariNikah}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 16),
            ...hasil.kombinasi.map((k) {
              final key = '${k.hari} ${k.pasaran}';
              final tanggal = hasil.tanggalPerKombinasi[key] ?? [];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : const Color(0xFF3A3A3C),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$key (${k.hariNilai} + ${k.pasaranNilai} = ${hasil.neptuHariNikah})',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tanggal terdekat:',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    ...tanggal.map(
                      (t) => Padding(
                        padding: const EdgeInsets.only(left: 8, top: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• '),
                            Expanded(child: Text(dateFmt.format(t))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
