import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Slim gradient bar pinned at the top indicating scroll progress (0.0 to 1.0).
class ScrollProgressBar extends StatelessWidget {
  final double progress;

  const ScrollProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 3,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryCyan,
                AppTheme.accentIndigo,
                AppTheme.accentEmerald,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryCyan,
                blurRadius: 6,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
