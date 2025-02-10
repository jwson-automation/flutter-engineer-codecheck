import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/theme_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/search_screen.dart';
import 'package:flutter_engineer_codecheck/shared/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  runApp(const ProviderScope(child: RepositorySearchApp()));
}

/// GitHub 리포지토리 검색 앱
class RepositorySearchApp extends ConsumerWidget {
  const RepositorySearchApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      title: 'GitHub Repository Search',
      themeMode: themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const SearchScreen(),
    );
  }
}
