import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Smooth reveal animation on load with optional delay.
class RevealOnScroll extends HookWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideOffset;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.slideOffset = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: duration);

    useEffect(() {
      Future.delayed(delay, () {
        if (context.mounted) {
          controller.forward();
        }
      });
      return null;
    }, const []);

    final animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutCubic,
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Transform.translate(
            offset: Offset(0, slideOffset * (1.0 - animation.value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
