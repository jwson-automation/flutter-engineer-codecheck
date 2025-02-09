import 'dart:convert';
import 'dart:io';

import 'package:flutter_engineer_codecheck/data/error/exceptions.dart';
import 'package:http/http.dart' as http;

/// GitHub API エラー処理のためのミックスイン
mixin GitHubErrorHandlerMixin {
  /// API レスポンスを処理し、エラーを処理するメソッド
  Future<T> handleGitHubResponse<T>({
    required Future<http.Response> Function() apiCall,
    required T Function(Map<String, dynamic>) onSuccess,
  }) async {
    try {
      final response = await apiCall();
      final statusCode = response.statusCode;
      final body = json.decode(response.body) as Map<String, dynamic>;

      if (statusCode == 200 || statusCode == 201) {
        return onSuccess(body);
      }

      throw _handleErrorResponse(statusCode, body);
    } on SocketException {
      throw GitHubNetworkException('ネットワーク接続を確認してください。');
    } on FormatException {
      throw GitHubParsingException('レスポンスデータの解析に失敗しました。');
    } catch (e) {
      if (e is GitHubException) rethrow;
      throw GitHubUnknownException('不明なエラーが発生しました: $e');
    }
  }

  /// エラーレスポンスの処理
  Exception _handleErrorResponse(
    int statusCode,
    Map<String, dynamic> body,
  ) {
    final message = body['message'] as String?;
    switch (statusCode) {
      case 304:
        return GitHubNotModifiedException(message ?? '変更はありません。');
      case 422:
        return GitHubValidationException(message ?? '入力値が正しくないか、リクエストが多すぎます。');
      case 503:
        return GitHubServiceUnavailableException(
            message ?? 'サービスは一時的に利用できません。',);
      default:
        return GitHubUnknownException(message ?? '不明なエラーが発生しました。');
    }
  }

  /// 入力値の検証
  void validateSearchParams({
    required String searchText,
    String? sort,
    String? order,
    int? perPage,
    int? page,
  }) {
    if (searchText.trim().isEmpty) {
      throw GitHubValidationException('検索キーワードを入力してください。');
    }

    final validSorts = ['stars', 'forks', 'help-wanted-issues', 'updated'];
    if (sort != null && !validSorts.contains(sort)) {
      throw GitHubValidationException('無効なソートオプションです: $validSorts');
    }

    final validOrders = ['desc', 'asc'];
    if (order != null && !validOrders.contains(order)) {
      throw GitHubValidationException('無効な順序オプションです: $validOrders');
    }

    if (perPage != null && (perPage < 1 || perPage > 100)) {
      throw GitHubValidationException('ページあたりのアイテム数は1-100の間である必要があります。');
    }

    if (page != null && page < 1) {
      throw GitHubValidationException('ページ番号は1以上である必要があります。');
    }
  }
}
