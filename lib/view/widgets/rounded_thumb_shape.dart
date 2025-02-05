import 'package:flutter/material.dart';

class RoundedRectSliderThumbShape extends SliderComponentShape {
  final double width;
  final double height;

  RoundedRectSliderThumbShape({this.width = 20.0, this.height = 12.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(width, height);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    final RRect thumbRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: height),
      Radius.circular(4.0), // Adjust for rounded corners
    );

    canvas.drawRRect(thumbRect, paint);
  }
}
