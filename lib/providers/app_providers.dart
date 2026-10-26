import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Controls the app's ThemeMode (dark / light).
final isDarkModeProvider = StateProvider<bool>((ref) => true);

/// Controls which project filter is active ('All', 'Flutter / Mobile', 'Desktop & Web').
final projectFilterProvider = StateProvider<String>((ref) => 'All');

/// Controls back-to-top FAB visibility based on scroll offset.
final showBackToTopProvider = StateProvider<bool>((ref) => false);
