import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/cat.dart';

class CatApiService {
  static const String baseUrl =
      'https://api.thecatapi.com/v1/images/search?has_breeds=1';
  static const String apiKey =
      'live_p9cy297ylKoWrFM5rm3HkAXFXP1S1jgp2FduEAzLA6TsaqgG67fEA8jNkVHAEIcc';

  Future<http.Response> getRandomCat() async {
    final url = Uri.parse(baseUrl);
    final response = await http.get(
      url,
      headers: {
        'x-api-key': apiKey,
      },
    );

    if (kDebugMode) {
      debugPrint('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        debugPrint('Data received: ${response.body.length} bytes');
      }
    }

    return response;
  }

  Future<List<Cat>> getMultipleCats(int count) async {
    List<Cat> cats = [];

    for (int i = 0; i < count; i++) {
      try {
        final response = await getRandomCat();

        if (response.statusCode == 200) {
          List<dynamic> data = json.decode(response.body);
          if (data.isNotEmpty) {
            cats.add(Cat.fromJson(data.first as Map<String, dynamic>));
          }
        }
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Error loading cat ${i + 1}: $e');
        }
      }
    }

    return cats;
  }
}
