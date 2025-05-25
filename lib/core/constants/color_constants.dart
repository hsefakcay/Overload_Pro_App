import 'package:flutter/material.dart';

class MuscleGroupColors {
  static const Map<String, Color> colors = {
    'Göğüs': Color(0xFFFFD700), // Altın sarısı
    'Omuz': Color(0xFF4CAF50), // Yeşil
    'Bacak': Color(0xFF2196F3), // Mavi
    'Sırt': Color(0xFFE91E63), // Pembe
    'Kol': Color(0xFFFF5722), // Turuncu
    'Karın': Color(0xFF9C27B0), // Mor
    'Kalça': Color(0xFF795548), // Kahverengi
    // English translations for fallback
    'Chest': Color(0xFFFFD700),
    'Shoulders': Color(0xFF4CAF50),
    'Legs': Color(0xFF2196F3),
    'Back': Color(0xFFE91E63),
    'Arms': Color(0xFFFF5722),
    'Abs': Color(0xFF9C27B0),
    'Glutes': Color(0xFF795548),
  };

  static Color getColorForMuscleGroup(String? muscleGroup) {
    return colors[muscleGroup] ?? const Color(0xFF9E9E9E); // Varsayılan gri renk
  }

  static Color getLightColorForMuscleGroup(String? muscleGroup) {
    final color = getColorForMuscleGroup(muscleGroup);
    return color.withOpacity(0.2);
  }
}
