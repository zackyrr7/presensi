import 'dart:convert';

import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class LoginService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse('$url/login'),
        body: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        var token = data['token'];
        final GetStorage box = GetStorage();
        box.write('token', token);

        return data;
      } else {
        return {
          'success': false,
          'message': 'Login Gagal, Periksa username dan password anda',
        };
      }
    } catch (e) {
      return {'succes': false, 'message': 'An error Occurred: $e'};
    }
  }
}
