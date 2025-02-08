import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 検索テキストを提供するプロバイダー
final StateProvider<String> searchTextProvider = StateProvider<String>((ref) => '');