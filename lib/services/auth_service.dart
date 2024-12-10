import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/auth_response.dart';

class AuthService {
  Future<AuthResponse> login(String email, String password) async {
    final url = Uri.parse(
        'http://127.0.0.1:5000/api/login'); // Update with actual URL of your API

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Parse the response body if login is successful
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        // Handle non-200 status codes
        var errorResponse = jsonDecode(response.body);
        throw Exception(' ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (error) {
      // Handle exceptions, like network issues
      throw Exception('$error');
    }
  }

  Future<AuthResponse> register(
      String name, String email, String password) async {
    final url = Uri.parse(
        'http://127.0.0.1:5000/api/register'); // Update with actual URL of your API

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Parse the response body if login is successful
        return AuthResponse.fromJson(jsonDecode(response.body));
      } else {
        // Handle non-200 status codes
        var errorResponse = jsonDecode(response.body);
        throw Exception(' ${errorResponse['message'] ?? 'Unknown error'}');
      }
    } catch (error) {
      // Handle exceptions, like network issues
      throw Exception('$error');
    }
  }
}
