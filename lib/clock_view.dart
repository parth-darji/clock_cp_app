import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatelessWidget {
  const ClockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      child: CustomPaint(
        painter: ClockPainter(),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY);

    var fillBrush = Paint();
    fillBrush.color = Color(0xFF444974);

    var outlineBrush = Paint();
    outlineBrush.color = Color(0xFFEAECFF);
    outlineBrush.strokeWidth = 16;
    outlineBrush.style = PaintingStyle.stroke;

    var centerFillBrush = Paint();
    centerFillBrush.color = Color(0xFFEAECFF);

    var secHandBrush = Paint();
    secHandBrush.color = Colors.orange[300]!;
    secHandBrush.strokeWidth = 8;
    secHandBrush.style = PaintingStyle.stroke;
    secHandBrush.strokeCap = StrokeCap.round;

    var minHandBrush = Paint();
    minHandBrush.shader = RadialGradient(
      colors: [Color(0xFF748EF6), Color(0xFF77DDFF)],
    ).createShader(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
    );
    minHandBrush.strokeWidth = 16;
    minHandBrush.style = PaintingStyle.stroke;
    minHandBrush.strokeCap = StrokeCap.round;

    var hourHandBrush = Paint();
    hourHandBrush.shader = RadialGradient(
      colors: [Color(0xFFEA74AB), Color(0xFFC279FB)],
    ).createShader(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
    );
    hourHandBrush.strokeWidth = 16;
    hourHandBrush.style = PaintingStyle.stroke;
    hourHandBrush.strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hourHandX = centerX + 60 * cos(-180 * pi / 180);
    var hourHandY = centerX + 60 * sin(-180 * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minHandX = centerX + 70 * cos(-45 * pi / 180);
    var minHandY = centerX + 70 * sin(-45 * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var secHandX = centerX + 80 * cos(-90 * pi / 180);
    var secHandY = centerX + 80 * sin(-90 * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
