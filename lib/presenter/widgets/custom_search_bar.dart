import 'package:flutter/material.dart';

/// カスタム検索バーウィジェット
/// 
/// リポジトリ検索用のテキスト入力フィールドを提供します。
/// 検索アイコン、クリアボタン、検索実行機能を含みます。
class CustomSearchBar extends StatelessWidget {
  /// テキスト入力を制御するコントローラー
  final TextEditingController controller;
  
  /// 検索ボタンが押された時のコールバック
  final VoidCallback onSearch;
  
  /// クリアボタンが押された時のコールバック
  final VoidCallback onClear;

  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'リポジトリを検索...',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: onClear,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onSubmitted: (_) => onSearch(),
          onChanged: (_) {},
        ),
      );
} 