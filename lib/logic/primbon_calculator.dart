import 'primbon_data.dart';

/// Hasil perhitungan weton satu tanggal
class WetonResult {
  const WetonResult({
    required this.hari,
    required this.pasaran,
    required this.nilai,
    required this.hariNilai,
    required this.pasaranNilai,
    required this.hariIdx,
  });

  final String hari;
  final String pasaran;
  final int nilai;
  final int hariNilai;
  final int pasaranNilai;
  final int hariIdx;
}

/// Hasil kecocokan jodoh
class JodohResult {
  const JodohResult({
    required this.nama,
    required this.deskripsi,
    required this.totalNeptu,
    required this.lanang,
    required this.wedok,
  });

  final String nama;
  final String deskripsi;
  final int totalNeptu;
  final WetonResult lanang;
  final WetonResult wedok;
}

/// Satu kombinasi hari + pasaran untuk nikah
class KombinasiNikah {
  const KombinasiNikah({
    required this.hari,
    required this.pasaran,
    required this.hariNilai,
    required this.pasaranNilai,
    required this.hariIdx,
    required this.neptu,
  });

  final String hari;
  final String pasaran;
  final int hariNilai;
  final int pasaranNilai;
  final int hariIdx;
  final int neptu;
}

/// Rekomendasi hari nikah lengkap
class NikahRecommendation {
  const NikahRecommendation({
    required this.totalNeptu,
    required this.angkaTarget,
    required this.neptuHariNikah,
    required this.kombinasi,
    required this.tanggalPerKombinasi,
  });

  final int totalNeptu;
  final int angkaTarget;
  final int neptuHariNikah;
  final List<KombinasiNikah> kombinasi;
  final Map<String, List<DateTime>> tanggalPerKombinasi;
}

/// Kalkulator primbon — port 1:1 dari JavaScript source lama
class PrimbonCalculator {
  /// Konversi DateTime.weekday (1=Senin..7=Minggu) ke getDay() (0=Minggu..6=Sabtu)
  static int weekdayToJsDay(int weekday) => weekday % 7;

  /// Hitung weton dari tanggal (hanya bagian tanggal, tanpa jam)
  static WetonResult hitungWeton(DateTime tgl) {
    final d = DateTime(tgl.year, tgl.month, tgl.day);
    final hariIdx = weekdayToJsDay(d.weekday);
    final hari = hariList[hariIdx];

    // Selisih hari dari acuan Kamis Kliwon (22 Jan 1970)
    final base = DateTime(
      pasaranBaseDate.year,
      pasaranBaseDate.month,
      pasaranBaseDate.day,
    );
    final diff = d.difference(base).inDays;
    final pasarIdx = ((diff % 5) + 5) % 5;
    final pasar = pasaranList[pasarIdx];

    return WetonResult(
      hari: hari.nama,
      pasaran: pasar.nama,
      nilai: hari.nilai + pasar.nilai,
      hariNilai: hari.nilai,
      pasaranNilai: pasar.nilai,
      hariIdx: hariIdx,
    );
  }

  /// Kecocokan jodoh: total neptu % 8 → hasilMap
  static JodohResult hitungKecocokan(DateTime tglLanang, DateTime tglWedok) {
    final l = hitungWeton(tglLanang);
    final w = hitungWeton(tglWedok);
    final total = l.nilai + w.nilai;
    final hasil = hasilMap[total % 8]!;

    return JodohResult(
      nama: hasil[0],
      deskripsi: hasil[1],
      totalNeptu: total,
      lanang: l,
      wedok: w,
    );
  }

  /// Cari kombinasi hari+pasaran dengan neptu tertentu
  static List<KombinasiNikah> cariKombinasiNeptu(int targetNeptu) {
    final kombinasi = <KombinasiNikah>[];
    for (var h = 0; h < hariList.length; h++) {
      for (var p = 0; p < pasaranList.length; p++) {
        final sum = hariList[h].nilai + pasaranList[p].nilai;
        if (sum == targetNeptu) {
          kombinasi.add(
            KombinasiNikah(
              hari: hariList[h].nama,
              pasaran: pasaranList[p].nama,
              hariNilai: hariList[h].nilai,
              pasaranNilai: pasaranList[p].nilai,
              hariIdx: h,
              neptu: targetNeptu,
            ),
          );
        }
      }
    }
    return kombinasi;
  }

  /// Cari [jumlah] tanggal terdekat dari [from] dengan weton tertentu
  static List<DateTime> cariTanggalDenganWeton({
    required int hariIdx,
    required String pasaranNama,
    DateTime? from,
    int jumlah = 5,
  }) {
    final hasil = <DateTime>[];
    final today = from ?? DateTime.now();
    var current = DateTime(today.year, today.month, today.day);

    final pasaranIdx = pasaranList.indexWhere((p) => p.nama == pasaranNama);
    if (pasaranIdx < 0) return hasil;

    final base = DateTime(
      pasaranBaseDate.year,
      pasaranBaseDate.month,
      pasaranBaseDate.day,
    );

    while (hasil.length < jumlah) {
      final dayOfWeek = weekdayToJsDay(current.weekday);
      final diff = current.difference(base).inDays;
      final currentPasaranIdx = ((diff % 5) + 5) % 5;

      if (dayOfWeek == hariIdx && currentPasaranIdx == pasaranIdx) {
        hasil.add(DateTime(current.year, current.month, current.day));
      }
      current = current.add(const Duration(days: 1));
    }
    return hasil;
  }

  /// Cari hari nikah: jumlah neptu gabungan mod 3 = 2
  static NikahRecommendation cariHariNikah(
    DateTime tglLanang,
    DateTime tglWedok, {
    DateTime? from,
    int tanggalPerKombinasi = 5,
  }) {
    final l = hitungWeton(tglLanang);
    final w = hitungWeton(tglWedok);
    final totalNeptu = l.nilai + w.nilai;

    var angkaTarget = totalNeptu;
    var neptuHariNikah = 0;
    var kombinasiCocok = <KombinasiNikah>[];

    // Terus cari sampai ada kombinasi valid (sama loop while source lama)
    while (kombinasiCocok.isEmpty) {
      while (angkaTarget % 3 != 2) {
        angkaTarget++;
      }
      neptuHariNikah = angkaTarget - totalNeptu;
      kombinasiCocok = cariKombinasiNeptu(neptuHariNikah);
      if (kombinasiCocok.isEmpty) {
        angkaTarget += 3;
      }
    }

    final tanggalMap = <String, List<DateTime>>{};
    for (final k in kombinasiCocok) {
      final key = '${k.hari} ${k.pasaran}';
      tanggalMap[key] = cariTanggalDenganWeton(
        hariIdx: k.hariIdx,
        pasaranNama: k.pasaran,
        from: from,
        jumlah: tanggalPerKombinasi,
      );
    }

    return NikahRecommendation(
      totalNeptu: totalNeptu,
      angkaTarget: angkaTarget,
      neptuHariNikah: neptuHariNikah,
      kombinasi: kombinasiCocok,
      tanggalPerKombinasi: tanggalMap,
    );
  }
}
