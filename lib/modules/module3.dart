import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class TargetChart extends StatefulWidget {
  @override
  _TargetChartState createState() => _TargetChartState();
}

class _TargetChartState extends State<TargetChart> {
  List<TextEditingController> _latControllers = [TextEditingController()];
  List<TextEditingController> _lonControllers = [TextEditingController()];

  final TextEditingController _x1Controller = TextEditingController(text: '0.0');
  final TextEditingController _y1Controller = TextEditingController(text: '0.0');

  double _x1 = 0.0, _y1 = 0.0;

  List<Point<double>> _points = [Point<double>(0.0, 0.0)]; // List to hold the points

  @override
  void initState() {
    super.initState();

    _x1Controller.addListener(_updatePoints);
    _y1Controller.addListener(_updatePoints);

    // Add listeners to the initial lat/lon controllers
    _latControllers[0].addListener(_updatePoints);
    _lonControllers[0].addListener(_updatePoints);
  }

  void _updatePoints() {
    setState(() {
      _x1 = double.tryParse(_x1Controller.text) ?? 0.0;
      _y1 = double.tryParse(_y1Controller.text) ?? 0.0;

      _points[0] = Point<double>(_x1, _y1);

      for (int i = 0; i < _latControllers.length; i++) {
        double lat = double.tryParse(_latControllers[i].text) ?? 0.0;
        double lon = double.tryParse(_lonControllers[i].text) ?? 0.0;
        if (i + 1 < _points.length) {
          _points[i + 1] = Point<double>(lat, lon);
        } else {
          _points.add(Point<double>(lat, lon));
        }
      }
    });
  }

  void _addNewPoint() {
    setState(() {
      _latControllers.add(TextEditingController());
      _lonControllers.add(TextEditingController());

      // Add listeners to the new controllers
      _latControllers.last.addListener(_updatePoints);
      _lonControllers.last.addListener(_updatePoints);

      _points.add(Point<double>(0.0, 0.0));
    });
  }

  void _deletePoint(int index) {
    setState(() {
      _latControllers.removeAt(index);
      _lonControllers.removeAt(index);
      _points.removeAt(index + 1); // +1 to account for point 0 in _points
    });
  }

  @override
  void dispose() {
    // _x1Controller.dispose();
    // _y1Controller.dispose();
    // _latControllers.forEach((controller) => controller.dispose());
    // _lonControllers.forEach((controller) => controller.dispose());
    // super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final circleRadius = screenWidth * 0.125; // Adjust this factor as needed

    return Scaffold(
      appBar: AppBar(
        title: Text('Target Chart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            Container(
              width: screenWidth * 0.8,
              height: screenWidth * 0.8,
              child: CustomPaint(
                size: Size(double.infinity, double.infinity),
                painter: RadarChartPainter(
                  circleRadius: circleRadius,
                  points: _points,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: const Divider(
                color: Color(0xCC4C4C4C), // Color of the line
                thickness: 0.5, // Thickness of the line
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "TP",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 90,
                          child:
                          TextField(
                            controller: _x1Controller,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Lon',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 90,
                          child:
                          TextField(
                            controller: _y1Controller,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              labelText: 'Lat',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                    child: const Divider(
                      color: Color(0xCC4C4C4C), // Color of the line
                      thickness: 0.5, // Thickness of the line
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _latControllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _latControllers[index],
                                    decoration: InputDecoration(labelText: 'Longitude for Point ${index + 1}'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextField(
                                    controller: _lonControllers[index],
                                    decoration: InputDecoration(labelText: 'Latitude for Point ${index + 1}'),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deletePoint(index),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _addNewPoint,
                    child: Text('Add New Point'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final double circleRadius;
  final List<Point<double>> points;

  RadarChartPainter({required this.circleRadius, required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Determine the maximum range needed to display all points
    double maxX = points[0].x, maxY = points[0].y;
    for (int i = 1; i < points.length; i++) {
      if (points[i].x.abs() > maxX) maxX = points[i].x.abs();
      if (points[i].y.abs() > maxY) maxY = points[i].y.abs();
    }

    // Calculate scaling factor based on the largest coordinate
    double scaleFactor = max(maxX, maxY) == 0 ? 1.0 : min(size.width, size.height) / (2 * max(maxX, maxY));
    scaleFactor *= 0.6;

    // Draw concentric circles
    for (double r = circleRadius; r <= circleRadius * 3; r += circleRadius) {
      paint.color = Color(0xCC4C4C4C);
      canvas.drawCircle(center, r, paint);
    }

    // Draw axes
    final double lastCircleRadius = circleRadius * 3;
    canvas.drawLine(
      Offset(center.dx, center.dy - lastCircleRadius),
      Offset(center.dx, center.dy + lastCircleRadius),
      paint,
    );
    canvas.drawLine(
      Offset(center.dx - lastCircleRadius, center.dy),
      Offset(center.dx + lastCircleRadius, center.dy),
      paint,
    );

    // Draw points
    final Point<double> centerPoint = points[0];
    for (int i = 0; i < points.length; i++) {
      final pointOffset = _calculateOffset(center, (points[i].y - centerPoint.y) * scaleFactor, (points[i].x - centerPoint.x) * scaleFactor);
      if (i == 0) {
        // Draw point 0 (square) at the center
        canvas.drawRect(
          Rect.fromCenter(center: pointOffset, width: 10.0, height: 10.0),
          Paint()..color = Colors.blue,
        );
      } else {
        // Draw other points as circles
        canvas.drawCircle(pointOffset, 5.0, Paint()..color = Colors.red);
      }
    }
  }

  Offset _calculateOffset(Offset center, double lat, double lon) {
    final double offsetX = lon;
    final double offsetY = -lat;
    return center.translate(offsetX, offsetY);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}