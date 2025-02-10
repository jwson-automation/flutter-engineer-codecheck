import 'package:flutter/material.dart';

/// ダークテーマの定義
ThemeData darkTheme = ThemeData.dark().copyWith(
  // Scaffoldの背景色を設定
  scaffoldBackgroundColor: const Color(0xFF1B262C),

  // AppBarのテーマを設定
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E2A3A),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
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

/// ライトテーマの定義
ThemeData lightTheme = ThemeData.light().copyWith(
  // Scaffoldの背景色を設定
  scaffoldBackgroundColor: Colors.white,

  // AppBarのテーマを設定
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),

  // テキストフィールドのデザイン
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey[100],
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),

  // ダイアログのテーマを設定
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
    elevation: 0,
  ),

  // カラースキームを設定
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.blue,
    error: Colors.redAccent,
  ),
);
