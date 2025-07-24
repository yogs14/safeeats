// file: lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // This is a placeholder for your actual backend URL
  final String _baseUrl = "https://api.yourbackend.com";

  // A mock function that simulates analyzing ingredients
  Future<Map<String, dynamic>> analyzeIngredients(String text) async {
    print("Sending to backend for analysis: $text");

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 2));

    // Return a hardcoded "fake" response for testing
    // In the real app, this would come from your backend server.
    return {
      "product_name": "Chips Barbecue Lay's",
      "allergens_found": ["Gluten", "Soy"],
      "nutri_score": "D",
      "nova_score": 4,
      "eco_score": "C"
    };
  }

  // --- Example of a real function ---
  // Future<Map<String, dynamic>> analyzeIngredientsReal(String text) async {
  //   final response = await http.post(
  //     Uri.parse('$_baseUrl/analyze'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'ingredients_text': text}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to load analysis from backend.');
  //   }
  // }
}