# Primbon App

Aplikasi mobile Flutter untuk perhitungan weton Jawa — kecocokan jodoh dan rekomendasi hari nikah.

## Fitur

- Hitung kecocokan weton pasangan (Lanang & Wedok)
- Cari hari nikah berdasarkan aturan neptu (mod 3 = 2)
- Riwayat perhitungan (5 terakhir)
- Panduan weton, daftar itungan 1-36, cara hitung hari nikah

## Algoritma (ringkas)

Port 1:1 dari aplikasi web Primbon AI (`lib/logic/primbon_calculator.dart`):

### 1. Hitung Weton
- **Neptu hari**: Senin=4, Selasa=3, Rabu=7, Kamis=8, Jumat=6, Sabtu=9, Minggu=5.
- **Neptu pasaran** (siklus 5): Kliwon=8, Legi=5, Pahing=9, Pon=7, Wage=4.
- Acuan: **22 Januari 1970 = Kamis Kliwon**. Indeks pasaran = `((selisihHari % 5) + 5) % 5`.
- **Neptu** = neptu hari + neptu pasaran.

### 2. Kecocokan Jodoh
- `total = neptuLanang + neptuWedok`
- `hasil = hasilMap[total % 8]` → 8 kategori: PESTHI(0), PEGAT(1), RATU(2), JODOH(3), TOPO(4), TINARI(5), PADU(6), SUJANAN(7).

### 3. Cari Hari Nikah
- Cari `angkaTarget >= totalNeptu` dengan **`angkaTarget % 3 == 2`**.
- `neptuHariNikah = angkaTarget - totalNeptu`.
- Cari kombinasi (hari + pasaran) yang neptunya pas; jika tidak ada, `angkaTarget += 3` dan ulangi.
- Tampilkan 5 tanggal terdekat per kombinasi yang cocok weton-nya.

## Setup pertama (jika belum ada folder android/ios)

```bash
flutter create . --org com.primbon --project-name primbon_app
flutter pub get
```

## Menjalankan

```bash
flutter pub get
flutter run
flutter test
dart run bin/verify_algorithm.dart
```

## Struktur

- `lib/logic/` — kalkulator & data primbon
- `lib/data/` — model & repository
- `lib/presentation/` — UI & state
