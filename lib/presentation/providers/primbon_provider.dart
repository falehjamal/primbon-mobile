import 'package:flutter/foundation.dart';

import '../../logic/primbon_calculator.dart';

enum ResultView { none, jodoh }

class PrimbonProvider extends ChangeNotifier {
  DateTime? tglLanang;
  DateTime? tglWedok;
  JodohResult? hasilJodoh;
  ResultView resultView = ResultView.none;
  String? errorMessage;

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
    resultView = ResultView.jodoh;
    notifyListeners();
  }
}
