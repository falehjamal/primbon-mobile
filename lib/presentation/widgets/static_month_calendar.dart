import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../logic/primbon_calculator.dart';

class StaticMonthCalendar extends StatelessWidget {
  const StaticMonthCalendar({
    super.key,
    required this.month,
    required this.rekomendasi,
  });

  final DateTime month;
  final List<RekomendasiNikahHari> rekomendasi;

  static const _weekdayLabels = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];

  @override
  Widget build(BuildContext context) {
    final monthFmt = DateFormat('MMMM yyyy', 'id_ID');
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final firstDay = DateTime(month.year, month.month, 1);
    final startOffset = PrimbonCalculator.weekdayToJsDay(firstDay.weekday);

    final rekomendasiByDay = <int, RekomendasiNikahHari>{};
    for (final r in rekomendasi) {
      rekomendasiByDay[r.tanggal.day] = r;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              monthFmt.format(firstDay),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: _weekdayLabels
                  .map(
                    (label) => Expanded(
                      child: Text(
                        label,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              ((startOffset + daysInMonth + 6) / 7).ceil(),
              (weekIndex) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    children: List.generate(7, (dayIndex) {
                      final cellIndex = weekIndex * 7 + dayIndex;
                      final dayNum = cellIndex - startOffset + 1;

                      if (dayNum < 1 || dayNum > daysInMonth) {
                        return const Expanded(child: SizedBox(height: 44));
                      }

                      final entry = rekomendasiByDay[dayNum];
                      final isRekomendasi = entry != null;

                      return Expanded(
                        child: _DayCell(
                          day: dayNum,
                          isRekomendasi: isRekomendasi,
                          pasaranLabel: isRekomendasi
                              ? entry.pasaranLabelFromWeton
                              : null,
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

extension on RekomendasiNikahHari {
  String get pasaranLabelFromWeton {
    final parts = wetonLabel.split(' ');
    return parts.length > 1 ? parts.last : wetonLabel;
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.isRekomendasi,
    this.pasaranLabel,
  });

  final int day;
  final bool isRekomendasi;
  final String? pasaranLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          gradient: isRekomendasi ? AppTheme.nikahGradient : null,
          color: isRekomendasi
              ? null
              : Theme.of(context).brightness == Brightness.light
                  ? const Color(0xFFF5F5F7)
                  : const Color(0xFF3A3A3C),
          borderRadius: BorderRadius.circular(8),
          boxShadow: isRekomendasi
              ? [
                  BoxShadow(
                    color: AppColors.nikahEnd.withValues(alpha: 0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$day',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isRekomendasi ? FontWeight.w700 : FontWeight.w400,
                color: isRekomendasi
                    ? Colors.white
                    : Theme.of(context).colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
              ),
            ),
            if (isRekomendasi && pasaranLabel != null)
              Text(
                pasaranLabel!,
                style: const TextStyle(
                  fontSize: 8,
                  color: Colors.white70,
                  height: 1,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
