import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF60A5FA);
  static const Color primaryDark = Color(0xFF1D4ED8);
  static const Color primarySurface = Color(0xFFEFF6FF);

  // Secondary
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);

  // Accent
  static const Color accent = Color(0xFFF59E0B);
  static const Color accentLight = Color(0xFFFBBF24);

  // Neutrals
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE2E8F0);
  static const Color border = Color(0xFFCBD5E1);

  // Text
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textTertiary = Color(0xFF94A3B8);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Status
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Booking Status
  static const Color available = Color(0xFF10B981);
  static const Color booked = Color(0xFFEF4444);
  static const Color hold = Color(0xFFF59E0B);
  static const Color blocked = Color(0xFF6B7280);

  // Sport Colors
  static const Color futsal = Color(0xFF10B981);
  static const Color badminton = Color(0xFF3B82F6);
  static const Color basket = Color(0xFFF97316);
  static const Color tenis = Color(0xFF8B5CF6);
  static const Color sepakBola = Color(0xFF06B6D4);
  static const Color voli = Color(0xFFEC4899);

  // Dark Theme
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkCard = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2563EB), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFF97316)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF1E40AF), Color(0xFF7C3AED), Color(0xFFDB2777)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.divider, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.textTertiary,
          fontSize: 14,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primarySurface,
        selectedColor: AppColors.primary,
        labelStyle: GoogleFonts.plusJakartaSans(fontSize: 13),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.darkSurface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: GoogleFonts.plusJakartaSansTextTheme(
        ThemeData.dark().textTheme,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.darkTextPrimary),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.darkTextPrimary,
        ),
      ),
    );
  }
}
