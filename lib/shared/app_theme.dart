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
);
