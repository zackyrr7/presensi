import 'package:get_storage/get_storage.dart';
import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LemburService {
  Future<Map<String, dynamic>> getLembur(String bulan) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token Tidak ada'};
      }

      var response = await http.post(
        Uri.parse('$url/lembur/list-data'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({'bulan': bulan.isEmpty ? '6' : bulan}),
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
      print(e);
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> postLembur(
    String tanggal,
    String mulai,
    String selesai,
    String uraian_pekerjaan,
    int status,
  ) async {
    try {
      final box = GetStorage();
      final token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      final response = await http.post(
        Uri.parse('$url/lembur/simpan-lembur'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({
          'tanggal': tanggal, // ← typo diperbaiki
          'mulai': mulai,
          'selesai': selesai,
          'uraian_pekerjaan': uraian_pekerjaan,
          'status': status,
        }),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        return {'success': 401, 'message': 'Sesi telah habis'};
      } else {
        return {'success': false, 'message': 'Terjadi kesalahan server'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi error: $e'};
    }
  }

  Future<Map<String, dynamic>> hapusLembur(int id) async {
    try {
      final box = GetStorage();
      var token = box.read('token');
      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/lembur/hapus-lembur'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({'id': id.toString()}),
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

  Future<Map<String, dynamic>> updateLembur(
    int id,
    int status,
    String uraian_pekerjaan,
  ) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/lembur/update-lembur'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'id': id.toString(),
          'status': status.toString(),
          'uraian_pekerjaan': uraian_pekerjaan,
        }),
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
