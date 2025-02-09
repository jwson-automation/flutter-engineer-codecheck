import 'dart:convert';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:http/http.dart' as http;

// TODO : Paging 処理を実装する
// TODO : エラーハンドリングを実装する ( inheritanceで実装しようか )

/// GitHub APIを使用してリポジトリを検索するクラス
class GitHubRepository {
  /// コンストラクタ
  GitHubRepository({http.Client? client}) : _client = client ?? http.Client();

  /// GitHub APIのベースURL
  final String baseUrl = 'https://api.github.com';

  /// HTTPクライアントのインスタンス
  /// テスト環境では、MockClientを注入することで、実際のHTTPリクエストなしで
  /// 事前に定義されたレスポンスを返すことができます。
  /// 本番環境では、デフォルトのhttp.Clientを使用します。
  final http.Client _client;

  /// GitHub APIのためのPersonal Access Token
  /// FlutterConfigを使用して環境変数から取得
  /// .envファイルのGITHUB_TOKEN情報を取得
  final String? token = FlutterConfig.get('GITHUB_TOKEN');

  /// 指定されたクエリでリポジトリを検索します
  Future<List<SearchResultModel>> searchRepositories({
    // 検索するリポジトリ名やキーワード
    required String searchText,
    // 'stars', 'forks', 'help-wanted-issues', 'updated' 並び順を指定
    String? sort,
    // 'desc', 'asc' 並び順指定
    String? order,
    // 1ページあたりに表示するリポジトリの数（デフォルト: 30）
    int perPage = 30,
    // 取得するページ番号（デフォルト: 1）
    int page = 1,
  }) async {
    final queryParams = {
      // 検索するテキスト
      'q': searchText,
      // 1ページに表示するリポジトリ数
      'per_page': perPage.toString(),
      // ページ番号
      'page': page.toString(),
    };

    // ソートオプションの有効性の確認
    final validSorts = ['stars', 'forks', 'help-wanted-issues', 'updated'];
    if (sort != null) {
      // 無効なソートオプションが指定された場合、エラーを投げる
      if (!validSorts.contains(sort)) {
        throw ArgumentError('無効なソートオプションです。有効なオプションは: $validSorts');
      }
      // 有効なソートオプションをクエリに追加
      queryParams['sort'] = sort;
    }

    // 順序オプションの有効性の確認
    final validOrders = ['desc', 'asc'];
    if (order != null) {
      // 無効な順序オプションが指定された場合、エラーを投げる
      if (!validOrders.contains(order)) {
        throw ArgumentError('無効な順序オプションです。"desc" または "asc" を指定してください');
      }

      // 有効な順序オプションをクエリに追加
      queryParams['order'] = order;
    }

    // APIリクエストのためのURLの生成
    final uri = Uri.parse('$baseUrl/search/repositories')
        .replace(queryParameters: queryParams);

    // APIリクエストの送信
    final response = await _client.get(
      uri,
      headers: {
        // GitHub APIのバージョンを指定
        'Accept': 'application/vnd.github.v3+json',
        if (token != null) 'Authorization': 'token $token',
      },
    );

    // レスポンスのステータスコードが200（成功）の場合、レスポンスデータを返す
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> items = data['items'] as List<dynamic>;

      return items.map((item) => SearchResultModel.fromJson(item)).toList();
    } else {
      // ステータスコードが200でない場合、例外をスロー
      throw Exception('リポジトリの検索に失敗しました: ${response.body}');
    }
  }
}
