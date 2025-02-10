import 'package:flutter/material.dart';

/// アプリ全体で使用するテキストスタイルの定義
mixin AppFontStyle {
  /// ダイアログタイトルのスタイル
  /// 使用: error_dialog.dart - エラーダイアログのタイトル表示
  static const dialogTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  /// ダイアログメッセージのスタイル
  /// 使用: error_dialog.dart - エラーダイアログの本文メッセージ表示
  static const dialogMessage = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  /// リポジトリ名のスタイル
  /// 使用: detail_repository_header.dart - リポジトリ詳細画面のリポジトリ名表示
  static const repositoryName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  /// リポジトリ説明のスタイル
  /// 使用: detail_repository_description.dart - リポジトリ詳細画面の説明文表示
  static const repositoryDescription = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// 検索結果タイトルのスタイル
  /// 使用: search_result_list_item.dart - 検索結果リストのリポジトリ名表示
  static const searchResultTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// 検索結果説明のスタイル
  /// 使用: search_result_list_item.dart - 検索結果リストのリポジトリ説明表示
  static const searchResultDescription = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// 統計数値のスタイル
  /// 使用: search_result_list_item.dart - スター数、フォーク数などの統計数値表示
  static const statsValue = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// メタ情報のスタイル
  /// 使用: detail_repository_dates.dart, detail_repository_language.dart - 言語、作成日、更新日などのメタ情報表示
  static const metaInfo = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// エラーメッセージのスタイル
  /// 使用: search_result_list.dart - 検索結果リストのエラーメッセージ表示
  static const errorMessage = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// 基本テキストスタイル
  /// 使用: search_result_list.dart - 検索結果が無い場合のメッセージ表示
  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  /// ボタンテキストスタイル
  /// 使用: detail_repository_link.dart - リポジトリリンクボタンのテキスト表示
  static const button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  /// アプリバーテキストスタイル
  /// 使用: search_screen.dart - アプリバーのタイトルテキスト表示
  static const appBarText = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );
}
