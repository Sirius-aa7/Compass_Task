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
  TextEditingController _AOS2degreesController = TextEditingController(text:'');
  TextEditingController _AOS2minutesController = TextEditingController(text:'');

  TextEditingController _radius3Controller =   TextEditingController(text: '');
  TextEditingController _angle3Controller =    TextEditingController(text: '');
  TextEditingController _angleDeg3Controller = TextEditingController(text: '');
  TextEditingController _angleMin3Controller = TextEditingController(text: '');
  TextEditingController _AOS3degreesController = TextEditingController(text:'');
  TextEditingController _AOS3minutesController = TextEditingController(text:'');

  TextEditingController _radius4Controller =   TextEditingController(text: '');
  TextEditingController _angle4Controller =    TextEditingController(text: '');
  TextEditingController _angleDeg4Controller = TextEditingController(text: '');
  TextEditingController _angleMin4Controller = TextEditingController(text: '');
  TextEditingController _AOS4degreesController = TextEditingController(text:'');
  TextEditingController _AOS4minutesController = TextEditingController(text:'');


  TextEditingController _safetyDistanceController = TextEditingController(text:'');
  TextEditingController _actualDistanceController = TextEditingController(text:'');

  double _radius2 = 0;
  double _angle2 = 0;
  double _radius3 = 0;
  double _angle3 = 0;
  double _radius4 = 0;
  double _angle4 = 0;


  final TextEditingController _x1Controller = TextEditingController(text: '0.0');
  final TextEditingController _y1Controller = TextEditingController(text: '0.0');
  final TextEditingController _alt1Controller = TextEditingController(text: '0.0');

  final TextEditingController _x2Controller = TextEditingController(text: '0.0');
  final TextEditingController _y2Controller = TextEditingController(text: '0.0');
  final TextEditingController _alt2Controller = TextEditingController(text: '0.0');

  final TextEditingController _x3Controller = TextEditingController(text: '0.0');
  final TextEditingController _y3Controller = TextEditingController(text: '0.0');
  final TextEditingController _alt3Controller = TextEditingController(text: '0.0');

  double _x1 = 0.0, _y1 = 0.0, _alt1=0;
  double _x2 = 0.0, _y2 = 0.0, _alt2=0;
  double _x3 = 0.0, _y3 = 0.0, _alt3=0;

  bool isSafeDistanceForObservation = false;

  @override
  void initState() {
    super.initState();

    _radius2Controller.addListener(_updatePoint2);
    _angle2Controller.addListener(_updatePoint2);
    _angleMin2Controller.addListener(_updatePoint2);
    _angleDeg2Controller.addListener(_updatePoint2);
    _AOS2degreesController.addListener(_plotPoints);
    _AOS2minutesController.addListener(_plotPoints);

    _radius3Controller.addListener(_updatePoint3);
    _angle3Controller.addListener(_updatePoint3);
    _angleMin3Controller.addListener(_updatePoint3);
    _angleDeg3Controller.addListener(_updatePoint3);
    _AOS3degreesController.addListener(_plotPoints);
    _AOS3minutesController.addListener(_plotPoints);

    _radius4Controller.addListener(_updatePoint4);
    _angle4Controller.addListener(_updatePoint4);
    _angleMin4Controller.addListener(_updatePoint4);
    _angleDeg4Controller.addListener(_updatePoint4);
    _AOS4degreesController.addListener(_plotPoints);
    _AOS4minutesController.addListener(_plotPoints);

    _x1Controller.addListener(_plotPoints);
    _y1Controller.addListener(_plotPoints);
    _alt1Controller.addListener(_plotPoints);
    _x2Controller.addListener(_plotPoints);
    _y2Controller.addListener(_plotPoints);
    _alt2Controller.addListener(_plotPoints);
    _x3Controller.addListener(_plotPoints);
    _y3Controller.addListener(_plotPoints);
    _alt3Controller.addListener(_plotPoints);

    _safetyDistanceController.addListener(_plotPoints);
    _actualDistanceController.addListener(_plotPoints);

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
      _alt1 = double.tryParse(_alt1Controller.text) ?? 0.0;

      _x2 = double.tryParse(_x2Controller.text) ?? 0.0;
      _y2 = double.tryParse(_y2Controller.text) ?? 0.0;
      _alt2 = double.tryParse(_alt2Controller.text) ?? 0.0;

      _x3 = double.tryParse(_x3Controller.text) ?? 0.0;
      _y3 = double.tryParse(_y3Controller.text) ?? 0.0;
      _alt3 = double.tryParse(_alt3Controller.text) ?? 0.0;


      double dx12 = _x2 - _x1;
      double dy12 = _y2 - _y1;
      double dz12 = _alt2 - _alt1;
      _radius2Controller.text = (sqrt(dx12*dx12 + dy12*dy12)).toStringAsFixed(2);
      // _radius2Controller.text = (sqrt(dx12*dx12 + dy12*dy12 + dz12*dz12)).toStringAsFixed(2);
      double distance12 = double.tryParse(_radius2Controller.text) ?? 0;
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

      if(dz12 == 0.0){
        _AOS2degreesController.text=0.toString();
        _AOS2minutesController.text=0.toString();
      } else{
        double elevationAngleRadians = atan2(dz12, distance12);
        double elevationAngleDegrees = elevationAngleRadians * (180 / pi);

        int degrees = elevationAngleDegrees.truncate();
        double fractionalPart = elevationAngleDegrees - degrees;
        int minutes = (fractionalPart * 60).round();

        _AOS2degreesController.text = degrees.toString();
        _AOS2minutesController.text = minutes.toString();
      }


      double dx32 = _x3 - _x2;
      double dy32 = _y3 - _y2;
      double dz32 = _alt3 - _alt2;
      _radius3Controller.text = (sqrt(dx32*dx32 + dy32*dy32)).toStringAsFixed(2);
      double distance32 = double.tryParse(_radius2Controller.text) ?? 0;
      _angle3Controller.text = (atan2(dy32, dx32) * 180 / pi).toString();

      double angle3 = double.parse(_angle3Controller.text);
      if(angle3<0){
        angle3+=360;
      }
      int degree3 = angle3.floor();
      int minute3 = ((angle3 - degree3) * 60).round();
      _angleDeg3Controller.text = degree3.toString();
      _angleMin3Controller.text = minute3.toString();
      print("dunp3");

      if(dz32 == 0.0){
        _AOS3degreesController.text = 0.toString();
        _AOS3minutesController.text = 0.toString();
      } else{
        double elevationAngleRadians = atan2(dz32, distance32);
        double elevationAngleDegrees = elevationAngleRadians * (180 / pi);

        int degrees = elevationAngleDegrees.truncate();
        double fractionalPart = elevationAngleDegrees - degrees;
        int minutes = (fractionalPart * 60).round();

        _AOS3degreesController.text = degrees.toString();
        _AOS3minutesController.text = minutes.toString();
      }


      double dx13 = _x3 - _x1;
      double dy13 = _y3 - _y1;
      double dz13 = _alt3 - _alt1;
      _radius4Controller.text = (sqrt(dx13*dx13 + dy13*dy13)).toStringAsFixed(2);
      double distance13 = double.tryParse(_radius2Controller.text) ?? 0;
      _angle4Controller.text = (atan2(dy13, dx13) * 180 / pi).toString();

      double angle4 = double.parse(_angle4Controller.text);
      if(angle4<0){
        angle4+=360;
      }
      int degree4 = angle4.floor();
      int minute4 = ((angle4 - degree4) * 60).round();
      _angleDeg4Controller.text = degree4.toString();
      _angleMin4Controller.text = minute4.toString();
      print("dunp4");

      if(dz13 == 0.0){
        _AOS4degreesController.text=0.toString();
        _AOS4minutesController.text=0.toString();
      } else{
        double elevationAngleRadians = atan2(dz13, distance13);
        double elevationAngleDegrees = elevationAngleRadians * (180 / pi);

        int degrees = elevationAngleDegrees.truncate();
        double fractionalPart = elevationAngleDegrees - degrees;
        int minutes = (fractionalPart * 60).round();

        _AOS4degreesController.text = degrees.toString();
        _AOS4minutesController.text = minutes.toString();
      }

      // Distance between OP and TP
      _actualDistanceController.text = _radius3Controller.text;
      double safetyDistance = double.parse(_safetyDistanceController.text);
      double actualDistance = double.parse(_actualDistanceController.text);

      if(safetyDistance <= actualDistance){
        isSafeDistanceForObservation = true;
      }else{
        isSafeDistanceForObservation = false;
      }

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
          padding: const EdgeInsets.all(5.0),
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
                    width: 90,
                    child: TextField(
                      controller: _y1Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) => _plotPoints(),
                      decoration: InputDecoration(
                        labelText: 'Lat', // "12-34567 E"  Easting
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      controller: _x1Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lon', // "12-34567 N" Northing
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      controller: _alt1Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) => _plotPoints(),
                      decoration: InputDecoration(
                        labelText: 'Alt', // "12-34567 E"  Easting
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
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
                    width: 90,
                    child: TextField(
                      controller: _y2Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                    width: 90,
                    child: TextField(
                      controller: _x2Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lon', // "12-34567 N" Northing
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      controller: _alt2Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) => _plotPoints(),
                      decoration: InputDecoration(
                        labelText: 'Alt', // "12-34567 E"  Easting
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ADD A GREEN CIRCLE AS LABEL HERE
                  Text(
                    "OP",
                    style: GoogleFonts.redHatDisplay(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF4C4C4C),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      controller: _y3Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                    width: 90,
                    child: TextField(
                      controller: _x3Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) => _plotPoints(),
                      // enabled: ENAunit,
                      decoration: InputDecoration(
                        labelText: 'Lon', // "12-34567 N" Northing
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    height: 30,
                    width: 90,
                    child: TextField(
                      controller: _alt3Controller,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) => _plotPoints(),
                      decoration: InputDecoration(
                        labelText: 'Alt', // "12-34567 E"  Easting
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
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
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                child: SizedBox(
                  width: 50,
                  child: Text('Range'),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                child: SizedBox(
                  width: 50,
                  child: Text('Bearing'),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                child: SizedBox(
                  width: 50,
                  child: Text('AOS'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
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
                width: 70,
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
                width: 40,
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
                width: 40,
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
                width: 40,
                child: TextField(
                  controller: _AOS2degreesController,
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
                width: 40,
                child: TextField(
                  controller: _AOS2minutesController,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
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
                width: 70,
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
                width: 40,
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
                width: 40,
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
                width: 40,
                child: TextField(
                  controller: _AOS3degreesController,
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
                width: 40,
                child: TextField(
                  controller: _AOS3minutesController,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
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
                width: 70,
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
                width: 40,
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
                width: 40,
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
                width: 40,
                child: TextField(
                  controller: _AOS4degreesController,
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
                width: 40,
                child: TextField(
                  controller: _AOS4minutesController,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: " '",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 15.0),
          child: const Divider(
            color: Color(0xCC4C4C4C), // Color of the line
            thickness: 0.5, // Thickness of the line
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 240,
                child: Text(
                  "Recommended Distance for Observation",
                  style: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: const Color(0xFF4C4C4C),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 70,
                child: TextField(
                  controller: _safetyDistanceController,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: 'km',
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
              SizedBox(
                width: 240,
                child: Text(
                  "Actual Safety Distance for Observation",
                  style: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    color: const Color(0xFF4C4C4C),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(5)),
              Container(
                height: 30,
                width: 70,
                child: TextField(
                  enabled: false,
                  controller: _actualDistanceController,
                  style: TextStyle(
                    fontSize: 10.0, // Set the font size here
                  ),
                  decoration: InputDecoration(
                    labelText: 'km',
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(color: Colors.green),
                    // ),
                    disabledBorder: OutlineInputBorder(
                        borderSide:
                        isSafeDistanceForObservation ?
                        BorderSide(color: Colors.green):
                        BorderSide(color: Colors.red)
                    ),
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
    canvas.drawPath(trianglePath, Paint()..color = Colors.red);

    // Draw point 3 (circle)
    canvas.drawCircle(point3Offset, circleRadiusPoint, Paint()..color = Colors.green);
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