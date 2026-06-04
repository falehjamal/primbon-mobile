import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/riwayat_item.dart';

const _keyRiwayat = 'riwayatWeton';
const _maxRiwayat = 5;

class RiwayatRepository {
  Future<List<RiwayatItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyRiwayat);
    if (raw == null || raw.isEmpty) return [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => RiwayatItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> save(List<RiwayatItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final trimmed = items.take(_maxRiwayat).toList();
    final encoded = jsonEncode(trimmed.map((e) => e.toJson()).toList());
    await prefs.setString(_keyRiwayat, encoded);
  }

  Future<void> add(RiwayatItem item) async {
    final current = await load();
    current.insert(0, item);
    await save(current);
  }
}
