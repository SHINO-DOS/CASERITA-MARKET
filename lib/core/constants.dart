import 'package:flutter/material.dart';

class AppConstants {
  // Colores principales
  static const Color primaryColor = Color(0xFF2E7D32); // Verde mercado
  static const Color accentColor = Color(0xFF81C784);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // Colores de Alertas de Especulación
  static const Color statusNormal = Color(0xFF4CAF50); // 🟢 Normal
  static const Color statusWarning = Color(0xFFFFB74D); // 🟡 Subiendo
  static const Color statusDanger = Color(0xFFE57373); // 🔴 Especulación

  // Configuración de negocio para el MVP
  static const double thresholdWarning = 0.15; // +15% del precio histórico
  static const double thresholdDanger = 0.35; // +35% Especulación crítica
}
