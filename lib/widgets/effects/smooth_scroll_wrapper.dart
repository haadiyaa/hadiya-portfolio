import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Wraps scrollable content to provide silky-smooth inertial mouse wheel scrolling.
class SmoothScrollWrapper extends HookWidget {
  final ScrollController controller;
  final Widget child;
  final double speedModifier;
  final Duration animationDuration;
  final Curve curve;

  const SmoothScrollWrapper({
    super.key,
    required this.controller,
    required this.child,
    this.speedModifier = 1.0,
    this.animationDuration = const Duration(milliseconds: 320),
    this.curve = Curves.easeOutCubic,
  });

  @override
  Widget build(BuildContext context) {
    final targetOffset = useRef<double?>(null);
    final isGliding = useRef(false);

    void onPointerSignal(PointerSignalEvent event) {
      if (event is PointerScrollEvent) {
        if (!controller.hasClients) return;

        // Continuous precision gestures (Mac trackpad / precision wheels with small deltas < 24px)
        // are handled natively by Flutter scroll physics for 120Hz liquid smoothness
        if (event.scrollDelta.dy.abs() < 24.0) {
          return;
        }

        // Register with pointerSignalResolver to handle smooth scrolling for discrete mouse wheel notches
        GestureBinding.instance.pointerSignalResolver.register(event, (resolved) {
          final scrollEvent = resolved as PointerScrollEvent;
          final max = controller.position.maxScrollExtent;
          final min = controller.position.minScrollExtent;

          // If offset deviated significantly (e.g., user dragged scrollbar), reset target
          final current = controller.offset;
          if (targetOffset.value == null ||
              !isGliding.value ||
              (current - targetOffset.value!).abs() > 300) {
            targetOffset.value = current;
          }

          final delta = scrollEvent.scrollDelta.dy * speedModifier;
          final nextTarget = (targetOffset.value! + delta).clamp(min, max);
          targetOffset.value = nextTarget;

          isGliding.value = true;
          controller
              .animateTo(
                nextTarget,
                duration: const Duration(milliseconds: 240),
                curve: Curves.easeOutCubic,
              )
              .whenComplete(() {
                isGliding.value = false;
              });
        });
      }
    }

    return Listener(
      onPointerSignal: onPointerSignal,
      child: child,
    );
  }
}
