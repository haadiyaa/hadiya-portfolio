import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Slim gradient bar pinned at the top indicating scroll progress.
/// Uses safe ScrollPosition dimension checks to prevent null-check errors on first load.
class ScrollProgressBar extends StatelessWidget {
  final ScrollController scrollController;

  const ScrollProgressBar({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: 3,
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: scrollController,
          builder: (context, _) {
            double progress = 0.0;

            if (scrollController.hasClients) {
              final position = scrollController.position;
              if (position.hasContentDimensions && position.hasPixels) {
                final maxScroll = position.maxScrollExtent;
                if (maxScroll > 0) {
                  progress = (position.pixels / maxScroll).clamp(0.0, 1.0);
                }
              }
            }

            if (progress <= 0.001) {
              return const SizedBox.shrink();
            }

            return FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
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
            );
          },
        ),
      ),
    );
  }
}
