import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../core/theme/app_theme.dart';
import '../../logic/primbon_data.dart';
import '../widgets/section_card.dart';
import 'info_itungan_screen.dart';

class InfoWetonScreen extends StatelessWidget {
  const InfoWetonScreen({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const InfoWetonScreen());

  @override
  Widget build(BuildContext context) {
    final hariItems = hariList.map((e) => MapEntry(e.nama, e.nilai)).toList();
    final pasaranItems =
        pasaranList.map((e) => MapEntry(e.nama, e.nilai)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.pituduhWeton)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: AppStrings.nilaiHari,
            child: ValueGrid(items: hariItems),
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: AppStrings.nilaiPasaran,
            child: ValueGrid(items: pasaranItems),
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: AppStrings.caraNgitung,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.caraNgitungDesc,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.6,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Contoh:\n${AppStrings.contohNgitung}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: AppStrings.tegesItungan,
            trailing: IconButton(
              icon: const Icon(Icons.list),
              tooltip: AppStrings.daftarItungan,
              onPressed: () =>
                  Navigator.push(context, InfoItunganScreen.route()),
            ),
            child: Column(
              children: AppStrings.tegesItems.map((item) {
                final name = item['title']!.split('. ').last;
                return InfoTile(
                  title: item['title']!,
                  description: item['desc']!,
                  accentColor: colorForItungan(name),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.welineSimbah,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
        ],
      ),
    );
  }
}
