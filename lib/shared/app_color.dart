import 'package:flutter/material.dart';

/// 앱에서 사용되는 색상 정의
class AppColor {
  /// 라이트 모드 색상
  static const lightColors = AppColorScheme(
    scaffoldBackground: Color(0xFFF5F5F5),
    appBarBackground: Color(0xFFFFFFFF),
    inputFieldBackground: Color(0xFFFFFFFF),
    dialogBackground: Color(0xFFFFFFFF),
    textPrimary: Color(0xFF000000),
    textSecondary: Color(0xFF666666),
    textTertiary: Color(0xFF999999),
    primary: Colors.blue,
    error: Colors.redAccent,
  );

  /// 다크 모드 색상
  static const darkColors = AppColorScheme(
    scaffoldBackground: Color(0xFF1B262C),
    appBarBackground: Color(0xFF1E2A3A),
    inputFieldBackground: Color(0xFF1E2A3A),
    dialogBackground: Color(0xFF1E2A3A),
    textPrimary: Colors.white,
    textSecondary: Colors.white70,
    textTertiary: Colors.white54,
    primary: Colors.blue,
    error: Colors.redAccent,
  );
}

/// 색상 스키마 클래스
class AppColorScheme {
  final Color scaffoldBackground;
  final Color appBarBackground;
  final Color inputFieldBackground;
  final Color dialogBackground;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color primary;
  final Color error;

  const AppColorScheme({
    required this.scaffoldBackground,
    required this.appBarBackground,
    required this.inputFieldBackground,
    required this.dialogBackground,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.primary,
    required this.error,
  });
} 