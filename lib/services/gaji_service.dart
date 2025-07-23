import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class GajiService {
  Future<Map<String, dynamic>> downloadPdf(
    int bulan,
    int tahun,
    int is_download,
  ) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/pdf/slip-gaji'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'bulan': bulan,
          'tahun': tahun,
          'is_download': is_download,
        }),
      );

      if (response.statusCode == 200) {
        final dir = await getApplicationDocumentsDirectory();
        final file = File('${dir.path}/slip-gaji.pdf');
        await file.writeAsBytes(response.bodyBytes);

        return {
          'status': true,
          'message': 'PDF berhasil diunduh',
          'file': file,
        };
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
