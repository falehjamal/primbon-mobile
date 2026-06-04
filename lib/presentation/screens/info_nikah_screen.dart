import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../widgets/section_card.dart';

class InfoNikahScreen extends StatelessWidget {
  const InfoNikahScreen({super.key});

  static Route<void> route() =>
      MaterialPageRoute(builder: (_) => const InfoNikahScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.caraCariNikah)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SectionCard(
            title: 'Prinsip Dasar',
            child: Text(
              'Kanggo golek dino nikah sing apik, wong Jawa nganggo aturan: '
              'jumlah gabungan neptu kudu dibagi 3 sisane 2.\n\n'
              'Neptu gabungan = Neptu Lanang + Neptu Wedok + Neptu Dino Nikah',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
          ),
          const SizedBox(height: 24),
          SectionCard(
            title: 'Langkah-langkah',
            child: Column(
              children: [
                InfoTile(
                  title: '1. Itung Neptu Pasangan',
                  description:
                      'Tambahake neptu weton lanang lan wedok. Contone: '
                      'Lanang (Senin Legi = 4+5 = 9) + Wedok (Rabu Pon = 7+7 = 14) = 23',
                ),
                InfoTile(
                  title: '2. Golek Angka Target',
                  description:
                      'Saka total neptu pasangan, golek angka luwih gedhe sing '
                      'yen dibagi 3 sisane 2. Contone: 23 → angka target = 26',
                ),
                InfoTile(
                  title: '3. Itung Neptu Dino Nikah',
                  description:
                      'Neptu dino nikah = Angka target - Total neptu pasangan. '
                      'Contone: 26 - 23 = 3',
                ),
                InfoTile(
                  title: '4. Golek Kombinasi Hari + Pasaran',
                  description:
                      'Golek hari lan pasaran sing jumlahe pas karo neptu dino nikah. '
                      'Yen ora ana, target dinaikke +3.',
                ),
                InfoTile(
                  title: '5. Temokke Tanggal',
                  description:
                      'Sistem golek tanggal terdekat saka saiki sing cocog karo weton kasebut.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Conto Lengkap:\n'
              'Lanang: Senin Legi (4+5 = 9)\n'
              'Wedok: Rabu Pon (7+7 = 14)\n'
              'Total: 9 + 14 = 23\n\n'
              'Target (mod 3 = 2): 26\n'
              'Neptu dino nikah: 26 - 23 = 3\n\n'
              'Ora ana kombinasi hari+pasaran = 3,\n'
              'Ngunggahke target: 29, neptu = 6\n'
              'Ora ana kombinasi = 6,\n'
              'Ngunggahke target: 32, neptu = 9\n'
              'Kombinasi = 9: Minggu Wage (5+4)\n\n'
              'Sistem golek tanggal Minggu Wage terdekat!',
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Aturan mod 3 = 2 iki dipercaya nggawe omah-omah luwih berkah lan lancar.',
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
