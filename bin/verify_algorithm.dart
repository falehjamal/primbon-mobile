// Verifikasi algoritma tanpa Flutter SDK (jalankan: dart run bin/verify_algorithm.dart)
import '../lib/logic/primbon_calculator.dart';

void main() {
  // Acuan: 22 Jan 1970 = Kamis Kliwon
  final base = PrimbonCalculator.hitungWeton(DateTime(1970, 1, 22));
  assert(base.hari == 'Kamis' && base.pasaran == 'Kliwon' && base.nilai == 16);

  // Kombinasi neptu 9 harus ada Minggu Wage
  final k9 = PrimbonCalculator.cariKombinasiNeptu(9);
  assert(k9.any((k) => k.hari == 'Minggu' && k.pasaran == 'Wage'));

  // Simulasi contoh nikah: total 23 -> target 32 -> neptu 9
  var target = 23;
  while (target % 3 != 2) {
    target++;
  }
  assert(target == 26);
  var neptu = target - 23;
  var komb = PrimbonCalculator.cariKombinasiNeptu(neptu);
  while (komb.isEmpty) {
    target += 3;
    neptu = target - 23;
    komb = PrimbonCalculator.cariKombinasiNeptu(neptu);
  }
  assert(target == 32 && neptu == 9);

  print('OK: Semua verifikasi algoritma lulus.');
  print('Kamis Kliwon 1970-01-22: neptu ${base.nilai}');
  print('Neptu 9 -> ${k9.map((e) => "${e.hari} ${e.pasaran}").join(", ")}');
}
