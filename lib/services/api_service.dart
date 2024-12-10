import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api.example.com';

  static Future<http.Response> fetchOutfits() async {
    final url = Uri.parse('$baseUrl/outfits');
    return await http.get(url);
  }

  // Metode lain untuk API
}
