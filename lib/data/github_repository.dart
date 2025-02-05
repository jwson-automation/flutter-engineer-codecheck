import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:http/http.dart' as http;

// TODO : テストコード作成
// TODO : Paging 処理を実装する
// TODO : エラーハンドリングを実装する ( inheritanceで実装しようか )

/// GitHub APIを使用してリポジトリを検索するクラス
class GitHubRepository {
  /// GitHub APIのベースURL
  final String baseUrl = 'https://api.github.com';

  /// GitHub APIのためのPersonal Access Token
  /// FlutterConfigを使用して環境変数から取得
  /// .envファイルのGITHUB_TOKEN情報を取得
  final String? token = FlutterConfig.get('GITHUB_TOKEN');

  /// 指定されたクエリでリポジトリを検索します
  Future<Map<String, dynamic>> searchRepositories({
    required String searchText, // 検索するリポジトリ名やキーワード
    String? sort, // 'stars', 'forks', 'help-wanted-issues', 'updated' 並び順を指定
    String? order, // 'desc', 'asc' 並び順指定
    int perPage = 30, // 1ページあたりに表示するリポジトリの数（デフォルト: 30）
    int page = 1, // 取得するページ番号（デフォルト: 1）
  }) async {
    final queryParams = {
      'q': searchText, // 検索するテキスト
      'per_page': perPage.toString(), // 1ページに表示するリポジトリ数
      'page': page.toString(), // ページ番号
    };

    // ソートオプションの有効性の確認
    final validSorts = ['stars', 'forks', 'help-wanted-issues', 'updated'];
    if (sort != null) {
      // 無効なソートオプションが指定された場合、エラーを投げる
      if (!validSorts.contains(sort)) {
        throw ArgumentError('無効なソートオプションです。有効なオプションは: $validSorts');
      }
      queryParams['sort'] = sort; // 有効なソートオプションをクエリに追加
    }

    // 順序オプションの有効性の確認
    final validOrders = ['desc', 'asc'];
    if (order != null) {
      // 無効な順序オプションが指定された場合、エラーを投げる
      if (!validOrders.contains(order)) {
        throw ArgumentError('無効な順序オプションです。"desc" または "asc" を指定してください');
      }
      queryParams['order'] = order; // 有効な順序オプションをクエリに追加
    }

    // APIリクエストのためのURLの生成
    final uri = Uri.parse('$baseUrl/search/repositories')
        .replace(queryParameters: queryParams);

    // APIリクエストの送信
    final response = await http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token', // Personal Access Tokenをヘッダーに設定
        'Accept': 'application/vnd.github.v3+json', // GitHub APIのバージョンを指定
      },
    );

    // レスポンスのステータスコードが200（成功）の場合、レスポンスデータを返す
    if (response.statusCode == 200) {
      return json.decode(response.body); // レスポンスボディをデコードして返す
    } else {
      // ステータスコードが200でない場合、例外をスロー
      throw Exception('リポジトリの検索に失敗しました: ${response.body}');
    }
  }
}
