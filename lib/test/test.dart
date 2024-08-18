import 'dart:math';

import 'package:flutter/material.dart';

class DrawingScreen extends StatefulWidget {
  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<Offset?> points = [];
  bool isCircleDetected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              points.add(details.localPosition);
            });
          },
          onPanEnd: (details) {
            _checkIfCircle();
          },
          child: CustomPaint(
            painter: DrawingPainter(points),
            size: Size.infinite,
          ),
        ),
      ),
    );
  }

  void _checkIfCircle() {
    if (points.length < 5) return;

    double centerX = 0;
    double centerY = 0;
    double radius = 0;

    // Calculate the center of the drawing
    double sumX = 0;
    double sumY = 0;
    points.forEach((point) {
      if (point != null) {
        sumX += point.dx;
        sumY += point.dy;
      }
    });
    centerX = sumX / points.length;
    centerY = sumY / points.length;

    // Calculate the average radius
    double sumRadius = 0;
    points.forEach((point) {
      if (point != null) {
        double dx = point.dx - centerX;
        double dy = point.dy - centerY;
        sumRadius += sqrt(dx * dx + dy * dy);
      }
    });
    radius = sumRadius / points.length;

    // Check if the points are within the circle radius
    double tolerance = 10.0; // Allowable deviation
    bool isCircle = points.every((point) {
      if (point != null) {
        double dx = point.dx - centerX;
        double dy = point.dy - centerY;
        double distance = sqrt(dx * dx + dy * dy);
        return (distance - radius).abs() <= tolerance;
      }
      return false;
    });

    setState(() {
      isCircleDetected = isCircle;
    });

    if (isCircleDetected) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Circle Detected'),
          content: Text('You drew a circle!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  points.clear();
                  isCircleDetected = false;
                });
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  DrawingPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}