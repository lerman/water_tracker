import 'dart:ui';
import 'package:flutter/material.dart';


class GlassContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final double borderOpacity;

  final BoxShape shape;

  const GlassContainer({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.borderRadius = 20,
    this.blur = 15,
    this.borderOpacity = 0.2,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: shape == BoxShape.circle ? BorderRadius.circular(1000) : BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              shape: shape,
              color: Colors.white.withOpacity(0.4),
              borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(borderOpacity),
                width: 1.5,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
