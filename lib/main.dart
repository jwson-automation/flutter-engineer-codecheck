import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_engineer_codecheck/presenter/providers/theme_provider.dart';
import 'package:flutter_engineer_codecheck/presenter/search_screen.dart';
import 'package:flutter_engineer_codecheck/shared/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  runApp(
    /// DevicePreview で画面プレビューを行う ( Screen Sizeの変更と確認のため )
    DevicePreview(
      enabled: !kReleaseMode,// リリースモードでは無効
      builder: (context) => const ProviderScope(child: RepositorySearchApp()),
    ),
  );
}

/// GITHUB リポジトリ検索アプリ
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'), // 韓国語
        Locale('en'), // 英語
        Locale('ja'), // 日本語
      ],
    );
  }
}
