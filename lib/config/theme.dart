import 'package:flutter/material.dart';

ThemeData get generateGreenTheme {
  return generateTheme(
    primary: Color(0xFF351C1D),
    primaryAccent: Color.fromARGB(255, 102, 56, 59),
    textPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFB28F5F),
    secondaryAccent: Color(0xFFDAB986),
    textSecondary: Color(0xFF000000),
    tertiaty: Color(0xFF1F1F1F),
    tertiaryAccent: Color(0xFF383838),
    surface: Color(0xFFFFFFF5),
    secondarySurface: Color(0xFFFFFFFD),
    error: Color(0xFF4E0000),
  );
}

ThemeData generateTheme({
  required Color primary,
  required Color secondary,
  required Color tertiaty,
  required Color surface,
  required Color secondarySurface,
  required Color textPrimary,
  required Color textSecondary,
  required Color primaryAccent,
  required Color secondaryAccent,
  required Color tertiaryAccent,
  required Color error,
}) {
  return ThemeData(
    colorScheme: ColorScheme(
      primary: primary,
      secondary: secondary,
      tertiary: tertiaty,
      brightness: Brightness.light,
      error: error,
      onError: surface,
      onPrimary: surface,
      onSecondary: surface,
      onSurface: primary,
      surface: surface,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(primary.withValues(alpha: 0.7)),
      radius: const Radius.circular(16),
      thumbVisibility: const WidgetStatePropertyAll(true),
      trackVisibility: const WidgetStatePropertyAll(false),
    ),
    primaryColor: primary,
    fontFamily: 'Inter',
    scaffoldBackgroundColor: surface,
    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      foregroundColor: primary,
      shadowColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        color: primary,
        fontFamily: 'Inter',
        fontSize: 20,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(cursorColor: primary),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        // ZA CARDS KORISTIMO
        fontWeight: FontWeight.w300,
        color: textSecondary,
        fontSize: 14,
        leadingDistribution: TextLeadingDistribution.even,
      ),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, color: textSecondary, ),
      titleSmall: TextStyle(fontWeight: FontWeight.w600, color: textSecondary),
      bodySmall: TextStyle(fontWeight: FontWeight.w600, color: textSecondary),
      bodyMedium: TextStyle(fontWeight: FontWeight.w600, color: textSecondary),
      bodyLarge: TextStyle(fontWeight: FontWeight.w600, color: textSecondary),
      displayLarge: TextStyle(
        fontWeight: FontWeight.w600,
        color: textSecondary,
      ),
      displayMedium: TextStyle(
        fontWeight: FontWeight.w600,
        color: textSecondary,
      ),
      displaySmall: TextStyle(
        fontWeight: FontWeight.w600,
        color: textSecondary,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      suffixIconColor: primary,
      counterStyle: TextStyle(color: primary, fontWeight: FontWeight.w600),
      labelStyle: TextStyle(color: primary, fontWeight: FontWeight.w600),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primary, width: 2),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primary, width: 2),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      refreshBackgroundColor: surface,
    ),
    dialogTheme: DialogThemeData(backgroundColor: surface),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: primary,
      contentTextStyle: TextStyle(
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        color: surface,
      ),
    ),
    sliderTheme: const SliderThemeData(
      trackHeight: 3,
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 9),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: primaryAccent,
      selectedColor: secondary,
      checkmarkColor: secondaryAccent,
      shadowColor: primary,
      labelStyle: TextStyle(
        color: textPrimary,
        fontSize: 13,
        fontWeight: FontWeight.w700,
        fontFamily: 'Inter',
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    listTileTheme: ListTileThemeData(
      textColor: primary,
      iconColor: primary,
      style: ListTileStyle.drawer,
    ),
    iconTheme: IconThemeData(color: primary),
    cardTheme: CardThemeData(
      elevation: 4,
      shadowColor: primary,
      margin: const EdgeInsets.only(left: 16, right: 16),
      color: secondarySurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: primary, width: 2),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      extendedTextStyle: TextStyle(
        fontWeight: FontWeight.w800,
        fontFamily: 'Inter',
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        backgroundColor: WidgetStateProperty.all(primary),
        textStyle: WidgetStateProperty.all(
          TextStyle(color: surface, fontSize: 18),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        backgroundColor: WidgetStateProperty.all(primary),
        foregroundColor: WidgetStateProperty.all(textPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData( 
      selectedItemColor: primary,
      unselectedItemColor: secondary,
      backgroundColor: tertiaty,
    ),
  );
}
