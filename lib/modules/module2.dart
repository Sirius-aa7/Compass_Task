import 'package:flutter/material.dart';
import 'dart:math';

import 'package:google_fonts/google_fonts.dart';

class RadarChartScreen extends StatefulWidget {
  @override
  _RadarChartScreenState createState() => _RadarChartScreenState();
}

class _RadarChartScreenState extends State<RadarChartScreen> {

  TextEditingController _radius2Controller =   TextEditingController(text: '');
  TextEditingController _angle2Controller =    TextEditingController(text: '');
  TextEditingController _angleDeg2Controller = TextEditingController(text: '');
  TextEditingController _angleMin2Controller = TextEditingController(text: '');

  TextEditingController _radius3Controller =   TextEditingController(text: '');
  TextEditingController _angle3Controller =    TextEditingController(text: '');
  TextEditingController _angleDeg3Controller = TextEditingController(text: '');
  TextEditingController _angleMin3Controller = TextEditingController(text: '');

  TextEditingController _radius4Controller =   TextEditingController(text: '');
  TextEditingController _angle4Controller =    TextEditingController(text: '');
  TextEditingController _angleDeg4Controller = TextEditingController(text: '');
  TextEditingController _angleMin4Controller = TextEditingController(text: '');

  double _radius2 = 0;
  double _angle2 = 0;
  double _radius3 = 0;
  double _angle3 = 0;
  double _radius4 = 0;
  double _angle4 = 0;

  final TextEditingController _x1Controller = TextEditingController(text: '0.0');
  final TextEditingController _y1Controller = TextEditingController(text: '0.0');
  final TextEditingController _x2Controller = TextEditingController(text: '0.0');
  final TextEditingController _y2Controller = TextEditingController(text: '0.0');
  final TextEditingController _x3Controller = TextEditingController(text: '0.0');
  final TextEditingController _y3Controller = TextEditingController(text: '0.0');

  double _x1 = 0.0, _y1 = 0.0;
  double _x2 = 0.0, _y2 = 0.0;
  double _x3 = 0.0, _y3 = 0.0;

  // String _LPpolarTP = '';
  // String _OPpolarTP = '';
  // String _LPpolarOP = '';

  @override
  void initState() {
    super.initState();

    _radius2Controller.addListener(_updatePoint2);
    _angle2Controller.addListener(_updatePoint2);
    _angleMin2Controller.addListener(_updatePoint2);
    _angleDeg2Controller.addListener(_updatePoint2);
    
    _radius3Controller.addListener(_updatePoint3);
    _angle3Controller.addListener(_updatePoint3);
    _angleMin3Controller.addListener(_updatePoint3);
    _angleDeg3Controller.addListener(_updatePoint3);

    _radius4Controller.addListener(_updatePoint4);
    _angle4Controller.addListener(_updatePoint4);
    _angleMin4Controller.addListener(_updatePoint4);
    _angleDeg4Controller.addListener(_updatePoint4);

    _x1Controller.addListener(_plotPoints);
    _y1Controller.addListener(_plotPoints);
    _x2Controller.addListener(_plotPoints);
    _y2Controller.addListener(_plotPoints);
    _x3Controller.addListener(_plotPoints);
    _y3Controller.addListener(_plotPoints);
  }

  void _updatePoint2() {
    setState(() {
      _radius2 = double.tryParse(_radius2Controller.text) ?? 50;
      _angle2 = (double.tryParse(_angle2Controller.text) ?? 0) * (pi / 180); // Convert degrees to radians
      _angle2 = (-_angle2 + pi / 2) % (2 * pi); // Normalize angle to be within [0, 2π] and shift it by 90 degrees

      double angle2 = double.parse(_angle2Controller.text);
      if(angle2<0){
        angle2+=360;
      }
      int degree2 = angle2.floor();
      int minute2 = ((angle2 - degree2) * 60).round();
      print("luci2");
      _angleDeg2Controller.text = degree2.toString();
      print(_angle2Controller.text.toString());
      print(_angleDeg2Controller.text.toString());
      _angleMin2Controller.text = minute2.toString();
      print(_angleMin2Controller.text.toString());
      print("DONEE2");
    });
  }

  void _updatePoint3() {
    setState(() {
      _radius3 = double.tryParse(_radius3Controller.text) ?? 50;
      _angle3 = (double.tryParse(_angle3Controller.text) ?? 0) * (pi / 180); // Convert degrees to radians
      _angle3 = (-_angle3 + pi / 2) % (2 * pi); // Normalize angle to be within [0, 2π] and shift it by 90 degrees

      double angle3 = double.parse(_angle3Controller.text);
      if(angle3<0){
        angle3+=360;
      }
      int degree3 = angle3.floor();
      int minute3 = ((angle3 - degree3) * 60).round();
      print("luci3");
      _angleDeg3Controller.text = degree3.toString();
      print(_angle3Controller.text.toString());
      print(_angleDeg3Controller.text.toString());
      _angleMin3Controller.text = minute3.toString();
      print(_angleMin3Controller.text.toString());
      print("DONEE3");
    });
  }

  void _updatePoint4() {
    setState(() {
      _radius4 = double.tryParse(_radius4Controller.text) ?? 50;
      _angle4 = (double.tryParse(_angle4Controller.text) ?? 0) * (pi / 180);
      _angle4 = (-_angle4 + pi / 2) % (2 * pi);

      double angle4 = double.parse(_angle4Controller.text);
      if(angle4<0){
        angle4+=360;
      }
      int degree4 = angle4.floor();
      int minute4 = ((angle4 - degree4) * 60).round();
      print("luci4");
      _angleDeg4Controller.text = degree4.toString();
      print(_angle4Controller.text.toString());
      print(_angleDeg4Controller.text.toString());
      _angleMin4Controller.text = minute4.toString();
      print(_angleMin4Controller.text.toString());
      print("DONEE4");
    });
  }

  void _plotPoints() {
    setState(() {
      _x1 = double.tryParse(_x1Controller.text) ?? 0.0;
      _y1 = double.tryParse(_y1Controller.text) ?? 0.0;
      _x2 = double.tryParse(_x2Controller.text) ?? 0.0;
      _y2 = double.tryParse(_y2Controller.text) ?? 0.0;
      _x3 = double.tryParse(_x3Controller.text) ?? 0.0;
      _y3 = double.tryParse(_y3Controller.text) ?? 0.0;

      double dx12 = _x2 - _x1;
      double dy12 = _y2 - _y1;
      _radius2Controller.text = (sqrt(dx12 * dx12 + dy12 * dy12)).toStringAsFixed(1);
      _angle2Controller.text = (atan2(dy12, dx12) * 180 / pi).toStringAsFixed(4);
      double angle2 = double.parse(_angle2Controller.text);
      if(angle2<0){
        angle2+=360;
      }
      int degree2 = angle2.floor();
      int minute2 = ((angle2 - degree2) * 60).round();
      _angleDeg2Controller.text = degree2.toString();
      _angleMin2Controller.text = minute2.toString();
      print("dunp2");


      double dx13 = _x3 - _x1;
      double dy13 = _y3 - _y1;
      _radius3Controller.text = (sqrt(dx13 * dx13 + dy13 * dy13)).toString();
      _angle3Controller.text = (atan2(dy13, dx13) * 180 / pi).toString();

      double angle3 = double.parse(_angle3Controller.text);
      if(angle3<0){
        angle3+=360;
      }
      int degree3 = angle3.floor();
      int minute3 = ((angle3 - degree3) * 60).round();
      _angleDeg3Controller.text = degree3.toString();
      _angleMin3Controller.text = minute3.toString();
      print("dunp3");


      double dx32 = _x2 - _x3;
      double dy32 = _y2 - _y3;
      _radius4Controller.text = (sqrt(dx32 * dx32 + dy32 * dy32)).toString();
      _angle4Controller.text = (atan2(dy32, dx32) * 180 / pi).toString();

      double angle4 = double.parse(_angle4Controller.text);
      if(angle4<0){
        angle4+=360;
      }
      int degree4 = angle4.floor();
      int minute4 = ((angle4 - degree4) * 60).round();
      _angleDeg4Controller.text = degree4.toString();
      _angleMin4Controller.text = minute4.toString();
      print("dunp4");
    });
  }

  @override
  void dispose() {}

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
              radius4: _radius4,
              angle4: _angle4
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "LP",
                    style: GoogleFonts.redHatDisplay(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF4C4C4C),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    child: TextField(
                      controller: _y1Controller,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lat', // "12-34567 E"  Easting
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    child: TextField(
                      controller: _x1Controller,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lon', // "12-34567 N" Northing
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 30,
                  //   width: 60,
                  //   child: TextField(
                  //     // controller: pointEastConvertConttroller,
                  //     // keyboardType: TextInputType.number,
                  //     // onChanged: (value) => _updateResults(),
                  //     // enabled: ENAunit,
                  //     decoration: InputDecoration(
                  //       labelText: "Alt", // "12-34567 N" Northing
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
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
                    width: 60,
                    child: TextField(
                      controller: _y2Controller,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lat', // "12-34567 E"  Easting
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    child: TextField(
                      controller: _x2Controller,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lon', // "12-34567 N" Northing
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 30,
                  //   width: 60,
                  //   child: TextField(
                  //     // controller: pointEastConvertConttroller,
                  //     // keyboardType: TextInputType.number,
                  //     // onChanged: (value) => _updateResults(),
                  //     // enabled: ENAunit,
                  //     decoration: InputDecoration(
                  //       labelText: "Alt", // "12-34567 N" Northing
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "OP",
                    style: GoogleFonts.redHatDisplay(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF4C4C4C),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    child: TextField(
                      controller: _y3Controller,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lat', // "12-34567 E"  Easting
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    child: TextField(
                      controller: _x3Controller,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lon', // "12-34567 N" Northing
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 30,
                  //   width: 60,
                  //   child: TextField(
                  //     // controller: pointEastConvertConttroller,
                  //     // keyboardType: TextInputType.number,
                  //     // onChanged: (value) => _updateResults(),
                  //     // enabled: ENAunit,
                  //     decoration: InputDecoration(
                  //       labelText: "Alt", // "12-34567 N" Northing
                  //       border: OutlineInputBorder(),
                  //     ),
                  //   ),
                  // ),
                ],
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
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _radius2Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: 'km',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _angleDeg2Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: ' °',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _angleMin2Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: " '",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: ' °',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: " '",
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
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _radius3Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: 'km',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _angleDeg3Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: ' °',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _angleMin3Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: " '",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: ' °',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: " '",
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
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _radius4Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: 'km',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _angleDeg4Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: ' °',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  controller: _angleMin4Controller,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: " '",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: ' °',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 30,
                width: 50,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: " '",
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
  final double radius4;
  final double angle4;

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
    required this.radius4,
    required this.angle4,
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