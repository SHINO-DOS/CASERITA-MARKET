import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  static const String _apiKey = 'TU_GEMINI_API_KEY_AQUI';

  final GenerativeModel _model;

  GeminiService()
    : _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: _apiKey);

  Future<Map<String, dynamic>?> extraerDatosProducto(String textoLibre) async {
    final prompt =
        '''
    Analiza el siguiente texto de un comerciante en Bolivia y extrae los datos del producto en formato JSON estricto.
    Texto: "$textoLibre"

    Devuelve ÚNICAMENTE un objeto JSON válido con la siguiente estructura (si no encuentras un dato, ponlo vacío o 0):
    {
      "producto": "nombre del producto en minúsculas",
      "cantidad": número,
      "unidad": "arroba, quintal, kilo, etc",
      "precio": número en Bolivianos,
      "ubicacion": "mercado o zona mencionada",
      "ciudad": "ciudad de Bolivia (La Paz, El Alto, Cochabamba, Santa Cruz, etc.)",
      "mapaEnlace": ""
    }
     No agregues explicaciones, ni bloques de código markdown ```json ```. Solo el texto crudo del JSON.
    ''';

    try {
      final response = await _model.generateContent([Content.text(prompt)]);
      final rawText = response.text?.trim() ?? '{}';

      String cleanJson = rawText;
      if (cleanJson.startsWith('```')) {
        cleanJson = cleanJson
            .replaceAll('```json', '')
            .replaceAll('```', '')
            .trim();
      }

      return jsonDecode(cleanJson) as Map<String, dynamic>;
    } catch (e) {
      debugPrint("Error con Gemini API: $e");
      return null;
    }
  }
}
