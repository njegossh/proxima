import 'package:flutter/material.dart';

ThemeData generateTheme({
    required Color primary,
    required Color secondary,
    required Color tertiaty,
    required Color surface,
    Color error = Colors.red,
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
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primary,
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w600, color: primary),
      titleLarge: TextStyle(fontWeight: FontWeight.w600, color: primary),
      titleSmall: TextStyle(fontWeight: FontWeight.w600, color: primary),
      bodySmall: TextStyle(fontWeight: FontWeight.w600, color: primary),
      bodyMedium: TextStyle(fontWeight: FontWeight.w600, color: primary),
      bodyLarge: TextStyle(fontWeight: FontWeight.w600, color: primary),
      displayLarge: TextStyle(fontWeight: FontWeight.w600, color: primary),
      displayMedium: TextStyle(fontWeight: FontWeight.w600, color: primary),
      displaySmall: TextStyle(fontWeight: FontWeight.w600, color: primary),
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
      backgroundColor: surface,
      selectedColor: primary,
      checkmarkColor: surface,
      shadowColor: Colors.transparent,
      labelStyle: TextStyle(
        color: primary,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: primary, width: 2),
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: primary,
      iconColor: primary,
      style: ListTileStyle.drawer,
    ),
    iconTheme: IconThemeData(color: primary),
    cardTheme: CardThemeData(
      elevation: 6,
      shadowColor: primary,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      color: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
        side: BorderSide(color: primary, width: 2),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      extendedTextStyle: TextStyle( 
        fontWeight: FontWeight.w800,
        fontFamily: 'Inter',
      )
    ),
    textButtonTheme: TextButtonThemeData( 
      style: ButtonStyle( 
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        backgroundColor: WidgetStateProperty.all(primary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: surface,
            fontSize: 18,
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData( 
      style: ButtonStyle( 
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        backgroundColor: WidgetStateProperty.all(secondary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: surface,
            fontSize: 18,
          ),
        ),
      ),
    )
  );
}
