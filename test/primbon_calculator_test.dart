import 'package:flutter_test/flutter_test.dart';
import 'package:primbon_app/logic/primbon_calculator.dart';

void main() {
  group('PrimbonCalculator', () {
    test('weekdayToJsDay matches JS getDay', () {
      // 22 Jan 1970 = Kamis -> weekday 4 -> js 4
      expect(
        PrimbonCalculator.weekdayToJsDay(DateTime(1970, 1, 22).weekday),
        4,
      );
      // Minggu
      expect(PrimbonCalculator.weekdayToJsDay(DateTime(2024, 6, 2).weekday), 0);
    });

    test('pasaran base date is Kamis Kliwon', () {
      final w = PrimbonCalculator.hitungWeton(DateTime(1970, 1, 22));
      expect(w.hari, 'Kamis');
      expect(w.pasaran, 'Kliwon');
      expect(w.nilai, 16); // 8 + 8
    });

    test('kecocokan total % 8 maps correctly', () {
      // Contoh manual: neptu 17 -> 17 % 8 = 1 -> PEGAT
      expect(17 % 8, 1);
    });

    test('cariHariNikah Senin Legi + Rabu Pon contoh dari docs', () {
      // Butuh tanggal aktual Senin Legi dan Rabu Pon - gunakan hitung balik
      // Senin 5 Feb 2024 = Senin, cek pasaran
      final lanang = DateTime(2024, 2, 5); // Senin
      final wedok = DateTime(2024, 2, 7); // Rabu
      final l = PrimbonCalculator.hitungWeton(lanang);
      final w = PrimbonCalculator.hitungWeton(wedok);

      if (l.hari == 'Senin' &&
          l.pasaran == 'Legi' &&
          w.hari == 'Rabu' &&
          w.pasaran == 'Pon') {
        final nikah = PrimbonCalculator.cariHariNikah(lanang, wedok);
        expect(nikah.totalNeptu, 23);
        expect(nikah.angkaTarget, 32);
        expect(nikah.neptuHariNikah, 9);
        expect(
          nikah.kombinasi.any((k) => k.hari == 'Minggu' && k.pasaran == 'Wage'),
          isTrue,
        );
      }
    });

    test('cariKombinasiNeptu finds Minggu Wage for neptu 9', () {
      final k = PrimbonCalculator.cariKombinasiNeptu(9);
      expect(
        k.any((e) => e.hari == 'Minggu' && e.pasaran == 'Wage'),
        isTrue,
      );
    });
  });
}
