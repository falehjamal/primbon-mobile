import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../widgets/app_footer.dart';
import '../widgets/itungan_chip.dart';

class InfoItunganScreen extends StatelessWidget {
  const InfoItunganScreen({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const InfoItunganScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.daftarItungan)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ItunganGrid(),
          const SizedBox(height: 20),
          Text(
            AppStrings.polaItungan,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }
}
