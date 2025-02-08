import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/presenter/search_screen.dart';
import 'package:flutter_engineer_codecheck/shared/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  runApp(const ProviderScope(child: RepositorySearchApp()));
}

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
