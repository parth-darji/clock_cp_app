import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockView extends StatefulWidget {
  final double size;

  const ClockView({
    super.key,
    required this.size,
  });

  @override
  State<ClockView> createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  @override
  void initState() {
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: -pi / 2,
        child: CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  var dateTime = DateTime.now();

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
    outlineBrush.strokeWidth = 12;
    outlineBrush.style = PaintingStyle.stroke;

    var centerFillBrush = Paint();
    centerFillBrush.color = Color(0xFFEAECFF);

    var secHandBrush = Paint();
    secHandBrush.color = Colors.orange[300]!;
    secHandBrush.strokeWidth = 4;
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
    minHandBrush.strokeWidth = 8;
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
    hourHandBrush.strokeWidth = 12;
    hourHandBrush.style = PaintingStyle.stroke;
    hourHandBrush.strokeCap = StrokeCap.round;

    var dashBrush = Paint();
    dashBrush.color = Color(0xFFEAECFF);
    dashBrush.style = PaintingStyle.stroke;
    dashBrush.strokeCap = StrokeCap.round;
    dashBrush.strokeWidth = 1;

    canvas.drawCircle(center, radius - 40, fillBrush);
    canvas.drawCircle(center, radius - 40, outlineBrush);

    var hour = (dateTime.hour * 30) + (dateTime.minute * 0.5);
    var hourHandX = centerX + 60 * cos(hour * pi / 180);
    var hourHandY = centerX + 60 * sin(hour * pi / 180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHandBrush);

    var minute = dateTime.minute * 6;
    var minHandX = centerX + 70 * cos(minute * pi / 180);
    var minHandY = centerX + 70 * sin(minute * pi / 180);
    canvas.drawLine(center, Offset(minHandX, minHandY), minHandBrush);

    var sec = dateTime.second * 6;
    var secHandX = centerX + 80 * cos(sec * pi / 180);
    var secHandY = centerX + 80 * sin(sec * pi / 180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHandBrush);

    canvas.drawCircle(center, 16, centerFillBrush);

    var outerCircleRadius = radius;
    var innerCircleRadius = radius - 14;
    for (double i = 0; i < 360; i += 12) {
      var x1 = centerX + outerCircleRadius * cos(i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(i * pi / 180);

      var x2 = centerX + innerCircleRadius * cos(i * pi / 180);
      var y2 = centerX + innerCircleRadius * sin(i * pi / 180);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
