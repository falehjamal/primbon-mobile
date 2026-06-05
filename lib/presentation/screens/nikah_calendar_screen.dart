import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../logic/primbon_calculator.dart';
import '../widgets/app_footer.dart';
import '../widgets/static_month_calendar.dart';

enum _RentangTahun { satu, dua }

class NikahCalendarScreen extends StatefulWidget {
  const NikahCalendarScreen({
    super.key,
    required this.tglLanang,
    required this.tglWedok,
  });

  final DateTime tglLanang;
  final DateTime tglWedok;

  static Route<void> route({
    required DateTime tglLanang,
    required DateTime tglWedok,
  }) =>
      MaterialPageRoute(
        builder: (_) => NikahCalendarScreen(
          tglLanang: tglLanang,
          tglWedok: tglWedok,
        ),
      );

  @override
  State<NikahCalendarScreen> createState() => _NikahCalendarScreenState();
}

class _NikahCalendarScreenState extends State<NikahCalendarScreen> {
  _RentangTahun _rentang = _RentangTahun.satu;

  DateTime get _from {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime get _to {
    final days = _rentang == _RentangTahun.satu ? 365 : 730;
    return _from.add(Duration(days: days));
  }

  NikahRecommendation get _hasil =>
      PrimbonCalculator.cariHariNikah(
        widget.tglLanang,
        widget.tglWedok,
        from: _from,
        to: _to,
      );

  @override
  Widget build(BuildContext context) {
    final hasil = _hasil;
    final grouped = PrimbonCalculator.groupTanggalPerBulan(
      hasil.tanggalPerKombinasi,
    );
    final bulanList = PrimbonCalculator.bulanDalamRentang(_from, _to);

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.rekomendasiHariNikah)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _SummaryCard(hasil: hasil),
          const SizedBox(height: 20),
          SegmentedButton<_RentangTahun>(
            segments: const [
              ButtonSegment(
                value: _RentangTahun.satu,
                label: Text(AppStrings.satuTahun),
              ),
              ButtonSegment(
                value: _RentangTahun.dua,
                label: Text(AppStrings.duaTahun),
              ),
            ],
            selected: {_rentang},
            onSelectionChanged: (selected) {
              setState(() => _rentang = selected.first);
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  gradient: AppTheme.nikahGradient,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.legendRekomendasi,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...bulanList.map(
            (bulan) => StaticMonthCalendar(
              month: bulan,
              rekomendasi: grouped[bulan] ?? [],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.hasil});

  final NikahRecommendation hasil;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Neptu: ${hasil.totalNeptu}\n'
              'Angka Target (mod 3 = 2): ${hasil.angkaTarget}\n'
              'Neptu Hari Nikah: ${hasil.angkaTarget} - ${hasil.totalNeptu} = ${hasil.neptuHariNikah}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    height: 1.5,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.kombinasiWeton,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: hasil.kombinasi.map((k) {
                final label = '${k.hari} ${k.pasaran}';
                final count = hasil.tanggalPerKombinasi[label]?.length ?? 0;
                return Chip(
                  label: Text('$label ($count hari)'),
                  backgroundColor: AppColors.nikahStart.withValues(alpha: 0.12),
                  side: BorderSide(
                    color: AppColors.nikahEnd.withValues(alpha: 0.3),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
