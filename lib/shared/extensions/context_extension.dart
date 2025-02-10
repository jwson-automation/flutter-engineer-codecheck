import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// BuildContext 확장 기능
extension ContextExtension on BuildContext {
  /// 다국어 지원을 위한 확장 기능
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  /// Theme 접근을 위한 확장 기능
  ThemeData get theme => Theme.of(this);

  /// ColorScheme 접근을 위한 확장 기능
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// TextTheme 접근을 위한 확장 기능
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// MediaQuery 접근을 위한 확장 기능
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// 화면 크기 접근을 위한 확장 기능
  Size get screenSize => mediaQuery.size;
} 