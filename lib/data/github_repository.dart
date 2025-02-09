import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/data/error/error_handler_mixin.dart';
import 'package:flutter_engineer_codecheck/data/search_result_model.dart';
import 'package:http/http.dart' as http;

// TODO : Paging 処理を実装する
// TODO : エラーハンドリングを実装する ( inheritanceで実装しようか )

/// GitHub APIを使用してリポジトリを検索するクラス
class GitHubRepository with GitHubErrorHandlerMixin {
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
    // 入力値の検証
    validateSearchParams(
      searchText: searchText,
      sort: sort,
      order: order,
      perPage: perPage,
      page: page,
    );

    final queryParams = {
      'q': searchText,
      'per_page': perPage.toString(),
      'page': page.toString(),
      if (sort != null) 'sort': sort,
      if (order != null) 'order': order,
    };

    final uri = Uri.parse('$baseUrl/search/repositories')
        .replace(queryParameters: queryParams);

    return handleGitHubResponse<List<SearchResultModel>>(
      apiCall: () => _client.get(
        uri,
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          if (token != null) 'Authorization': 'token $token',
        },
      ),
      onSuccess: (json) {
        final items = json['items'] as List<dynamic>;
        return items.map((item) => SearchResultModel.fromJson(item)).toList();
      },
    );
  }
}
