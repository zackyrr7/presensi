import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ProfileService {
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final box = GetStorage();
      var token = box.read('token');
      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/profile'),
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

  Future<Map<String, dynamic>> updatePassword(
    String password,
    String password2,
  ) async {
    try {
      final box = GetStorage();
      var token = box.read('token');
      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }
      var response = await http.post(
        Uri.parse('$url/profile/update-pass'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({'password': password, 'password2': password2}),
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

  Future<Map<String, dynamic>> updatePhoto(File? file) async {
    try {
      final box = GetStorage();
      var token = box.read('token');
      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      // Cek apakah file tersedia
      if (file == null) {
        return {'success': false, 'message': 'File tidak tersedia'};
      }

      var uri = Uri.parse('$url/profile/update-foto');

      var request =
          http.MultipartRequest('POST', uri)
            ..headers.addAll({
              "Authorization": "Bearer $token",
              // Jangan pakai Content-Type manual, biarkan MultipartRequest yang atur
            })
            ..files.add(
              await http.MultipartFile.fromPath(
                'file',
                file.path,
              ), // 'file' adalah nama field sesuai backend
            );

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
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
