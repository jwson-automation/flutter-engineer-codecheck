import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'presenter/search_screen.dart';
import 'shared/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  runApp(const RepositorySearchApp());
}

/// GitHub 레포지토리 검색 앱
/// GitHub リポジトリ検索アプリ
class RepositorySearchApp extends StatelessWidget {
  const RepositorySearchApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'GitHub Repository Search',
        theme: customTheme,
        home: const SearchScreen(),
      );
}
