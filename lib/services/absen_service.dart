import 'dart:io';

import 'package:get/get.dart';
import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class AbsenService {
  Future<Map<String, dynamic>> cekInOut() async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/absensi/cekinout'),
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

  Future<Map<String, dynamic>> postAbsen(
    String clock_type,
    String location,
    File? file,
  ) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/absensi/simpan'),
      );


      request.headers['Authorization'] = 'Bearer $token';

      request.fields['clock_type'] = clock_type;
      request.fields['location'] = location;

      if (file != null && await file.exists()) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file', // ✅ sesuaikan dengan backend
            file.path,
            contentType: MediaType('image', 'jpeg'), // opsional
          ),
        );
      }

      
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else if (response.statusCode == 401) {
        return {'success': 401, 'message': 'Sesi telah habis'};
      } else {
        return {
          'success': false,
          'message': 'Terjadi kesalahan server: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi error: $e'};
    }
  }

  Future<Map<String, dynamic>> hapusCuti(int id) async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$url/cuti/hapus-cuti'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['id'] = id.toString();

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
