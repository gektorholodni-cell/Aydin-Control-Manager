import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'cloud_backend.dart';

/// Личные финансы пользователя. В облачном режиме хранятся в таблице
/// `personal_finance` (каждый видит только свою строку), в демо-режиме —
/// на устройстве.
class PersonalFinanceStore {
  const PersonalFinanceStore();

  static const _localKey = 'structra.personal_finance';

  Future<Map<String, dynamic>?> load() async {
    if (CloudBackend.instance.hasSession) {
      final row = await Supabase.instance.client
          .from('personal_finance')
          .select('data')
          .maybeSingle();
      return row?['data'] as Map<String, dynamic>?;
    }
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_localKey);
    return raw == null ? null : jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> save(Map<String, dynamic> data) async {
    if (CloudBackend.instance.hasSession) {
      final client = Supabase.instance.client;
      await client.from('personal_finance').upsert(<String, dynamic>{
        'user_id': client.auth.currentUser!.id,
        'data': data,
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      });
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localKey, jsonEncode(data));
  }
}
