import 'package:flutter/material.dart';
import 'dart:math';

class RadarChartScreen extends StatefulWidget {
  @override
  _RadarChartScreenState createState() => _RadarChartScreenState();
}

class _RadarChartScreenState extends State<RadarChartScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _radius2Controller = TextEditingController(text: '50');
  final TextEditingController _angle2Controller = TextEditingController(text: '0');
  final TextEditingController _radius3Controller = TextEditingController(text: '50');
  final TextEditingController _angle3Controller = TextEditingController(text: '0');

  double _radius2 = 50;
  double _angle2 = 0;
  double _radius3 = 50;
  double _angle3 = 0;

  @override
  void initState() {
    super.initState();

    _radius2Controller.addListener(_updatePoint2);
    _angle2Controller.addListener(_updatePoint2);
    _radius3Controller.addListener(_updatePoint3);
    _angle3Controller.addListener(_updatePoint3);
  }

  void _updatePoint2() {
    setState(() {
      _radius2 = double.tryParse(_radius2Controller.text) ?? 50;
      _angle2 = (double.tryParse(_angle2Controller.text) ?? 0) * (pi / 180); // Convert degrees to radians
      _angle2 = (-_angle2 + pi / 2) % (2 * pi); // Normalize angle to be within [0, 2π] and shift it by 90 degrees
    });
  }

  void _updatePoint3() {
    setState(() {
      _radius3 = double.tryParse(_radius3Controller.text) ?? 50;
      _angle3 = (double.tryParse(_angle3Controller.text) ?? 0) * (pi / 180); // Convert degrees to radians
      _angle3 = (-_angle3 + pi / 2) % (2 * pi); // Normalize angle to be within [0, 2π] and shift it by 90 degrees
    });
  }

  @override
  void dispose() {
    _radius2Controller.dispose();
    _angle2Controller.dispose();
    _radius3Controller.dispose();
    _angle3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final circleRadius = screenWidth * 0.125; // Adjust this factor as needed

    return Column(
      children: [
        SizedBox(height: screenHeight*0.05),
        Container(
          width: screenWidth * 0.8,
          height: screenWidth * 0.8,
          child: CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: RadarChartPainter(
              circleRadius: circleRadius,
              radius2: _radius2,
              angle2: _angle2,
              radius3: _radius3,
              angle3: _angle3,
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
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _radius2Controller,
                        decoration: InputDecoration(labelText: 'Radius for Point 2'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _angle2Controller,
                        decoration: InputDecoration(labelText: 'Angle (degrees) for Point 2'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _radius3Controller,
                        decoration: InputDecoration(labelText: 'Radius for Point 3'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _angle3Controller,
                        decoration: InputDecoration(labelText: 'Angle (degrees) for Point 3'),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
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
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 25),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  child: Text('Range'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  child: Text('Bearing'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  child: Text('AOS'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "LP -> TP",
                // style: GoogleFonts.redHatDisplay(
                //   fontWeight: FontWeight.w900,
                //   color: const Color(0xFF4C4C4C),
                // ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 70,
                child: TextField(
                  // controller: pointNortConvertController,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: 'km', // "12-34567 E"  Easting
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: ' °', // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: " '", // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: ' °', // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: " '", // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "OP -> TP",
                // style: GoogleFonts.redHatDisplay(
                //   fontWeight: FontWeight.w900,
                //   color: const Color(0xFF4C4C4C),
                // ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 70,
                child: TextField(
                  // controller: pointNortConvertController,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: 'km', // "12-34567 E"  Easting
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: ' °', // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: " '", // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: ' °', // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: " '", // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "LP -> OP",
                // style: GoogleFonts.redHatDisplay(
                //   fontWeight: FontWeight.w900,
                //   color: const Color(0xFF4C4C4C),
                // ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 70,
                child: TextField(
                  // controller: pointNortConvertController,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: 'km', // "12-34567 E"  Easting
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: ' °', // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: " '", // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: ' °', // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 40,
                child: TextField(
                  // controller: pointEastConvertConttroller,
                  // keyboardType: TextInputType.number,
                  // onChanged: (value) => _updateResults(),
                  // enabled: ENAunit,
                  decoration: InputDecoration(
                    labelText: " '", // "12-34567 N" Northing
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final double circleRadius;
  final double radius2;
  final double angle2;
  final double radius3;
  final double angle3;

  // Adjust the size of the point icons here
  final double squareSize = 10.0; // Size of square
  final double triangleSize = 8.0; // Size of triangle
  final double circleRadiusPoint = 5.0; // Radius of circle

  RadarChartPainter({
    required this.circleRadius,
    required this.radius2,
    required this.angle2,
    required this.radius3,
    required this.angle3,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

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

    // Draw point 1 (square) at the center
    final point1Offset = center;
    canvas.drawRect(
      Rect.fromCenter(center: point1Offset, width: squareSize, height: squareSize),
      Paint()..color = Colors.blue,
    );

    // Calculate positions based on angles
    final point2Offset = _calculateOffset(center, radius2, angle2);
    final point3Offset = _calculateOffset(center, radius3, angle3);

    // Draw point 2 (triangle)
    final trianglePath = Path()
      ..moveTo(point2Offset.dx, point2Offset.dy - triangleSize)
      ..lineTo(point2Offset.dx - triangleSize, point2Offset.dy + triangleSize)
      ..lineTo(point2Offset.dx + triangleSize, point2Offset.dy + triangleSize)
      ..close();
    canvas.drawPath(trianglePath, Paint()..color = Colors.green);

    // Draw point 3 (circle)
    canvas.drawCircle(point3Offset, circleRadiusPoint, Paint()..color = Colors.red);
  }

  Offset _calculateOffset(Offset center, double radius, double angle) {
    final double offsetX = radius * cos(angle);
    final double offsetY = -radius * sin(angle);
    return center.translate(offsetX, offsetY);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}