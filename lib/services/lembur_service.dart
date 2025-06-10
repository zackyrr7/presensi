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
        print(data);
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
}
