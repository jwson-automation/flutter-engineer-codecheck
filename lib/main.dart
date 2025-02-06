import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'presenter/search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();

  runApp(const RepositorySearchApp());
}

/// github repository search app
class RepositorySearchApp extends StatelessWidget {
  const RepositorySearchApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'GitHub Repository Search',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SearchScreen(),
    );
}