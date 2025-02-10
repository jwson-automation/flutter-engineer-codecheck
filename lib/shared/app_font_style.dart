import 'package:flutter/material.dart';

/// アプリ全体で使用するテキストスタイルの定義
class AppFontStyle {
  /// ダイアログ関連のスタイル
  static const TextStyle dialogTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    height: 1.2,
  );

  /// ダイアログメッセージのスタイル
  static const TextStyle dialogMessage = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
    height: 1.5,
  );

  /// リポジトリ詳細画面のスタイル
  static const TextStyle repositoryName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.2,
  );

  /// リポジトリ詳細画面のスタイル
  static const TextStyle repositoryDescription = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
    height: 1.5,
  );

  /// 検索結果リストのスタイル
  static const TextStyle searchResultTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.2,
  );

  /// 検索結果リストのスタイル
  static const TextStyle searchResultDescription = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
    height: 1.5,
  );

  /// 統計情報のスタイル
  static const TextStyle statsValue = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.2,
  );

  /// 統計情報のラベルスタイル
  static const TextStyle statsLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.white54,
    height: 1.2,
  );

  /// メタ情報のスタイル（言語、日付など）
  static const TextStyle metaInfo = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
    height: 1.4,
  );

  /// エラーメッセージのスタイル
  static const TextStyle errorMessage = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.redAccent,
    height: 1.4,
  );

  /// 基本テキストスタイル
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Colors.white70,
    height: 1.5,
  );

  /// ボタンテキストスタイル
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.2,
  );

  /// アプリバーテキストスタイル
  static const TextStyle AppBarText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.2,
  );
}
