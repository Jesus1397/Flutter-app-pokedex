import 'package:flutter/material.dart';
import 'package:flutter_app_pokedex/utils/utils.dart';

class CurvedPainter extends CustomPainter {
  final Color color;

  CurvedPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final baseColor = color;
    final darkerColor = getDarkerColor(baseColor);

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          baseColor,
          darkerColor,
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height * 0.3));

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height * 0.3)
      ..quadraticBezierTo(size.width * 0.5, size.height * 0.42, size.width,
          size.height * 0.3) // Ajusta la curva
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
