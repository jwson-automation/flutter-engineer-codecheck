import 'package:flutter/material.dart';

/// アプリのテーマ定義
ThemeData customTheme = ThemeData.dark().copyWith(
  // scaffold の背景色を設定
  scaffoldBackgroundColor: const Color(0xFF1B262C),

  // appbar のテーマを設定
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E2A3A),
    elevation: 0,
  ),

  // テキストフィールドのデザイン
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E2A3A),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),

  // テキストテーマを設定
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.white70,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

  // ダイアログのテーマを設定
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF1E2A3A),
    elevation: 0,
  ),

  // カラースキームを設定
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.blue,
    error: Colors.redAccent,
  ),
);
