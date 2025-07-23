import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;

class LapkerService {
  Future<Map<String, dynamic>> getLapker(int bulan, int tahun) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/lapker/list-data'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: json.encode({'bulan': bulan, 'tahun': tahun}),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        // Jika langsung List, wrap dalam Map
        if (data is List) {
          return {'success': true, 'data': data};
        } else if (data is Map<String, dynamic>) {
          return data;
        } else {
          return {'success': false, 'message': 'Format data tidak dikenali'};
        }
      } else if (response.statusCode == 401) {
        return {'success': 401, 'message': 'Sesi telah habis'};
      } else {
        return {'success': false, 'message': 'Terjadi kesalahan server'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> updateIsdone(int id, int status) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/todolist/update-status-todolist'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({'id': id, 'status': status}),
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

  Future<Map<String, dynamic>> tambahLapker(
    String tanggal,
    String client,
    String uraian,
    String status,
  ) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/lapker/simpan-lapker'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'tanggal': tanggal,
          'client': client,
          'uraian': uraian,
          'status': status,
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

  Future<Map<String, dynamic>> updateLapker(
    String tanggal,
    String client,
    String uraian,
    String status,
    String idLapker,
  ) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/lapker/update-lapker'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'tanggal': tanggal,
          'client': client,
          'uraian': uraian,
          'status': status,
          'id': idLapker,
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

  Future<Map<String, dynamic>> hapus(String id) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/lapker/hapus-lapker'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({'id': id}),
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
