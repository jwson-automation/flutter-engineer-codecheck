import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/shared/app_color.dart';

/// ダークテーマの定義
ThemeData darkTheme = ThemeData.dark().copyWith(
  // Scaffoldの背景色を設定
  scaffoldBackgroundColor: AppColor.darkColors.scaffoldBackground,

  // AppBarのテーマを設定
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.darkColors.appBarBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColor.darkColors.textPrimary),
  ),

  // テキストフィールドのデザイン
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.darkColors.inputFieldBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),

  // ダイアログのテーマを設定
  dialogTheme: DialogTheme(
    backgroundColor: AppColor.darkColors.dialogBackground,
    elevation: 0,
  ),

  // カラースキームを設定
  colorScheme: ColorScheme.dark().copyWith(
    primary: AppColor.darkColors.primary,
    error: AppColor.darkColors.error,
  ),

  textTheme: TextTheme(
    headlineMedium: TextStyle(color: AppColor.darkColors.textPrimary),
    titleLarge: TextStyle(color: AppColor.darkColors.textPrimary),
    titleMedium: TextStyle(color: AppColor.darkColors.textPrimary),
    bodyLarge: TextStyle(color: AppColor.darkColors.textSecondary),
    bodyMedium: TextStyle(color: AppColor.darkColors.textSecondary),
    labelMedium: TextStyle(color: AppColor.darkColors.textTertiary),
  ),
);

/// ライトテーマの定義
ThemeData lightTheme = ThemeData.light().copyWith(
  // Scaffoldの背景色を設定
  scaffoldBackgroundColor: AppColor.lightColors.scaffoldBackground,

  // AppBarのテーマを設定
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.lightColors.appBarBackground,
    elevation: 0,
    iconTheme: IconThemeData(color: AppColor.lightColors.textPrimary),
  ),

  // テキストフィールドのデザイン
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColor.lightColors.inputFieldBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),

  // ダイアログのテーマを設定
  dialogTheme: DialogTheme(
    backgroundColor: AppColor.lightColors.dialogBackground,
    elevation: 0,
  ),

  // カラースキームを設定
  colorScheme: ColorScheme.light().copyWith(
    primary: AppColor.lightColors.primary,
    error: AppColor.lightColors.error,
  ),

  textTheme: TextTheme(
    headlineMedium: TextStyle(color: AppColor.lightColors.textPrimary),
    titleLarge: TextStyle(color: AppColor.lightColors.textPrimary),
    titleMedium: TextStyle(color: AppColor.lightColors.textPrimary),
    bodyLarge: TextStyle(color: AppColor.lightColors.textSecondary),
    bodyMedium: TextStyle(color: AppColor.lightColors.textSecondary),
    labelMedium: TextStyle(color: AppColor.lightColors.textTertiary),
  ),
);
