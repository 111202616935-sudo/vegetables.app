import 'package:flutter/material.dart';

class CustomCardSecondary extends StatelessWidget {
  final Widget child;
  final Color? leftColor;
  final bool useShadow;
  final double borderRadius;
  final double indicatorWidth;

  const CustomCardSecondary({
    super.key,
    required this.child,
    this.leftColor,
    this.useShadow = true,
    this.borderRadius = 12,
    this.indicatorWidth = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: useShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (leftColor != null)
                Container(
                  width: indicatorWidth,
                  color: leftColor,
                ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
