/// Data statis primbon Jawa — port dari source HTML/JS asli.

/// Indeks hari mengikuti JS Date.getDay(): 0=Minggu .. 6=Sabtu
class HariEntry {
  const HariEntry(this.nama, this.nilai);
  final String nama;
  final int nilai;
}

class PasaranEntry {
  const PasaranEntry(this.nama, this.nilai);
  final String nama;
  final int nilai;
}

/// Urutan pasaran pada siklus 5 hari (indeks 0 = Kliwon di acuan)
const List<PasaranEntry> pasaranList = [
  PasaranEntry('Kliwon', 8),
  PasaranEntry('Legi', 5),
  PasaranEntry('Pahing', 9),
  PasaranEntry('Pon', 7),
  PasaranEntry('Wage', 4),
];

/// hariMap[index] sesuai getDay(): 0=Minggu, 1=Senin, ...
const List<HariEntry> hariList = [
  HariEntry('Minggu', 5),
  HariEntry('Senin', 4),
  HariEntry('Selasa', 3),
  HariEntry('Rabu', 7),
  HariEntry('Kamis', 8),
  HariEntry('Jumat', 6),
  HariEntry('Sabtu', 9),
];

/// hasilMap[total % 8] — urutan sama dengan source lama
const Map<int, List<String>> hasilMap = {
  0: ['PESTHI', 'Rukun, tentrem, adem ayem tekan tuwo.'],
  1: ['PEGAT', 'Akeh masalah ekonomi, kekuasaan, utawa selingkuh.'],
  2: ['RATU', 'Jodoh banget, di ajeni wong sakupenge.'],
  3: ['JODOH', 'Cocok lan podo nrimo kekurangan.'],
  4: ['TOPO', 'Awal susah, mburi mulya.'],
  5: ['TINARI', 'Gampang rejeki lan kerep bejo.'],
  6: ['PADU', 'Kerep tukaran nanging ora nganti pegatan.'],
  7: ['SUJANAN', 'Rawan selingkuh lan konflik batin.'],
};

/// Pola 8 itungan berulang untuk nomor 1-36
const List<String> itunganPattern = [
  'PEGAT',
  'RATU',
  'JODOH',
  'TOPO',
  'TINARI',
  'PADU',
  'SUJANAN',
  'PESTHI',
];

/// Warna kategori itungan (untuk UI)
enum ItunganType {
  pegat,
  ratu,
  jodoh,
  topo,
  tinari,
  padu,
  sujanan,
  pesthi,
}

ItunganType itunganTypeFromName(String name) {
  switch (name) {
    case 'PEGAT':
      return ItunganType.pegat;
    case 'RATU':
      return ItunganType.ratu;
    case 'JODOH':
      return ItunganType.jodoh;
    case 'TOPO':
      return ItunganType.topo;
    case 'TINARI':
      return ItunganType.tinari;
    case 'PADU':
      return ItunganType.padu;
    case 'SUJANAN':
      return ItunganType.sujanan;
    default:
      return ItunganType.pesthi;
  }
}

String itunganAtNumber(int n) {
  if (n < 1 || n > 36) return '';
  return itunganPattern[(n - 1) % 8];
}

/// Acuan pasaran: 22 Januari 1970 = Kamis Kliwon (sama source lama)
final DateTime pasaranBaseDate = DateTime(1970, 1, 22);
