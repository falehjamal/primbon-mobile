import 'package:flutter/foundation.dart';

import '../../data/models/riwayat_item.dart';
import '../../data/repositories/riwayat_repository.dart';
import '../../logic/primbon_calculator.dart';

enum ResultView { none, jodoh, nikah }

class PrimbonProvider extends ChangeNotifier {
  PrimbonProvider({RiwayatRepository? repository})
      : _repository = repository ?? RiwayatRepository();

  final RiwayatRepository _repository;

  DateTime? tglLanang;
  DateTime? tglWedok;
  JodohResult? hasilJodoh;
  NikahRecommendation? hasilNikah;
  ResultView resultView = ResultView.none;
  List<RiwayatItem> riwayat = [];
  String? errorMessage;

  Future<void> init() async {
    riwayat = await _repository.load();
    notifyListeners();
  }

  void setTglLanang(DateTime? d) {
    tglLanang = d;
    notifyListeners();
  }

  void setTglWedok(DateTime? d) {
    tglWedok = d;
    notifyListeners();
  }

  bool get _tanggalLengkap => tglLanang != null && tglWedok != null;

  Future<void> hitungKecocokan() async {
    if (!_tanggalLengkap) {
      errorMessage = 'Tanggal lahir kudu di isi.';
      notifyListeners();
      return;
    }
    errorMessage = null;
    hasilJodoh = PrimbonCalculator.hitungKecocokan(tglLanang!, tglWedok!);
    hasilNikah = null;
    resultView = ResultView.jodoh;

    final l = hasilJodoh!.lanang;
    final w = hasilJodoh!.wedok;
    final now = DateTime.now();
    final waktu =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final item = RiwayatItem(
      label:
          '${hasilJodoh!.nama} — ${l.hari} ${l.pasaran} + ${w.hari} ${w.pasaran}',
      tglLanang: _formatIso(tglLanang!),
      tglWedok: _formatIso(tglWedok!),
      waktu: waktu,
    );
    await _repository.add(item);
    riwayat = await _repository.load();
    notifyListeners();
  }

  Future<void> cariHariNikah() async {
    if (!_tanggalLengkap) {
      errorMessage = 'Tanggal lahir kudu di isi.';
      notifyListeners();
      return;
    }
    errorMessage = null;
    hasilNikah = PrimbonCalculator.cariHariNikah(tglLanang!, tglWedok!);
    hasilJodoh = null;
    resultView = ResultView.nikah;
    notifyListeners();
  }

  Future<void> loadFromRiwayat(RiwayatItem item) async {
    final l = DateTime.tryParse(item.tglLanang);
    final w = DateTime.tryParse(item.tglWedok);
    if (l == null || w == null) return;
    tglLanang = DateTime(l.year, l.month, l.day);
    tglWedok = DateTime(w.year, w.month, w.day);
    await hitungKecocokan();
  }

  static String _formatIso(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
