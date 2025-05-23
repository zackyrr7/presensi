import 'dart:convert';
import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class HomeService {
  Future<Map<String, dynamic>> homeToday() async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/home/today'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // print(data);
        return data;
      } else if (response.statusCode == 401) {
        return {'succes': 401, 'message': 'Sesi telah habissss'};
      } else {
        return {'success': false, 'message': 'Terjadi kesalahan server'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> listAbsensToday() async {
    try {
      final box = GetStorage();
      var token = box.read('token');

      if (token == null) {
        return {'success': false, 'message': 'Token tidak ditemukan'};
      }

      var response = await http.post(
        Uri.parse('$url/home/all-today'),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
     
        return data;
      } else if (response.statusCode == 401) {
        return {'succes': 401, 'message': 'Sesi telah habissss'};
      } else {
        return {'success': false, 'message': 'Terjadi kesalahan server'};
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }
}
