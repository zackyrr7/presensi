import 'dart:convert';

import 'package:gopresent/constant.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      var response = await http.post(
        Uri.parse('$url/login'),
        body: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
    
        return json.decode(response.body);
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
