import 'dart:ui';

class ThemeUtils {
  // Primárias
  static const Color primaryColor = Color.fromRGBO(0, 80, 200, 1); // Azul forte
  static const Color secondaryColor =
      Color.fromRGBO(0, 80, 200, 0.5); // Azul suave

  // Neutros elegantes
  static const Color backgroundColor = Color(0xFFF5F5F5); // Cinza claro
  static const Color backgroundDark = Color(0xFF1C1C1E); // Cinza quase preto
  static const Color surfaceColor = Color(0xFFE5E5E5); // Para containers, cards

  // Texto e contraste
  static const Color textPrimary =
      Color(0xFF1A1A1A); // Quase preto (elegante e suave)
  static const Color textSecondary = Color(0xFF666666); // Cinza médio
  static const Color borderColor = Color(0xFFE0E0E0); // Bordas sutis

  // Destaques suaves
  static const Color accentSuccess = Color(0xFF4CAF50); // Verde formal
  static const Color accentWarning = Color(0xFFFFC107); // Amarelo sóbrio
  static const Color accentError = Color(0xFFD32F2F); // Vermelho moderado

  // Transparência de overlay
  static const Color overlay = Color.fromRGBO(0, 0, 0, 0.1);
}
