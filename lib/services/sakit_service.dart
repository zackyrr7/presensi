import 'dart:io';

import 'package:get/get.dart';
import 'package:gopresent/constant.dart';
import 'package:gopresent/modules/auth/controllers/reset_controller.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class SakitService {
  final ResetController resetController = Get.find<ResetController>();
  Future<Map<String, dynamic>> GetSakit() async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/sakit/list-data'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );
    

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else if (response.statusCode == 401) {
         
         return {'success': 401, 'message': 'Terjadi kesalahan server'};
      } else {
        return {'success': false, 'message': 'Terjadi kesalahan server'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> postsakit(
    String tanggalAwal,

    String keterangan,
    File? file, // ubah jadi nullable
  ) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/sakit/simpan-sakit'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['tanggal'] = tanggalAwal;

      request.fields['keterangan'] = keterangan;

      // Tambahkan file jika ada
      if (file != null) {
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

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

  Future<Map<String, dynamic>> hapusIzin(String id) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/izin/hapus-izin'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['id'] = id;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

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
}
