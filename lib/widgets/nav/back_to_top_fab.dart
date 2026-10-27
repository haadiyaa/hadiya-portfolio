import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

/// Floating back-to-top button that animates in/out based on scrollController offset.
/// Uses safe ScrollPosition dimension checks to prevent null-check errors on first load.
class BackToTopFab extends StatelessWidget {
  final ScrollController scrollController;
  final VoidCallback onScrollToTop;

  const BackToTopFab({
    super.key,
    required this.scrollController,
    required this.onScrollToTop,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, _) {
        bool isVisible = false;

        if (scrollController.hasClients) {
          final position = scrollController.position;
          if (position.hasContentDimensions && position.hasPixels) {
            isVisible = position.pixels > 400;
          }
        }

        return AnimatedScale(
          scale: isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          child: FloatingActionButton.small(
            onPressed: isVisible ? onScrollToTop : null,
            backgroundColor: AppTheme.primaryCyan,
            foregroundColor: const Color(0xFF090D16),
            elevation: 4,
            tooltip: 'Back to Top',
            child: const Icon(Icons.arrow_upward_rounded),
          ),
        );
      },
    );
  }
}
