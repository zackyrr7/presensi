import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<Map<String, dynamic>> GetNotification() async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.get(
        Uri.parse('$url/notifikasi'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
        return {'success': 401, 'message': 'Sesi telah habis'};
      } else {
        return {'success': false, 'message': 'Terjadi kesalahan server'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }
}
