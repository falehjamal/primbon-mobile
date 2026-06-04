class RiwayatItem {
  const RiwayatItem({
    required this.label,
    required this.tglLanang,
    required this.tglWedok,
    required this.waktu,
  });

  final String label;
  final String tglLanang;
  final String tglWedok;
  final String waktu;

  Map<String, dynamic> toJson() => {
        'label': label,
        'tglLanang': tglLanang,
        'tglWedok': tglWedok,
        'waktu': waktu,
      };

  factory RiwayatItem.fromJson(Map<String, dynamic> json) => RiwayatItem(
        label: json['label'] as String? ?? '',
        tglLanang: json['tglLanang'] as String? ?? '',
        tglWedok: json['tglWedok'] as String? ?? '',
        waktu: json['waktu'] as String? ?? '',
      );
}
