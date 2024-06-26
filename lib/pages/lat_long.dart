import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'buttons_beside_compass.dart';
import 'calculation.dart';
import 'dropdownENA.dart';

// class CalculatorScreen extends StatefulWidget {
//   @override
//   _CalculatorScreenState createState() => _CalculatorScreenState();
// }
//
// class _CalculatorScreenState extends State<CalculatorScreen> {
//   final TextEditingController _controllerA = TextEditingController();
//   final TextEditingController _controllerB = TextEditingController();
//   final Calculator _calculator = Calculator();
//
//   double _sum = 0.0;
//   double _product = 0.0;
//
//   void _updateResults() {
//     final double a = double.tryParse(_controllerA.text) ?? 0.0;
//     final double b = double.tryParse(_controllerB.text) ?? 0.0;
//     final results = _calculator.calculate(a, b);
//     setState(() {
//       _sum = results['sum'] ?? 0.0;
//       _product = results['product'] ?? 0.0;
//     });
//   }
//
//   @override
//   void dispose() {
//     _controllerA.dispose();
//     _controllerB.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _controllerA,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Input A',
//               ),
//               onChanged: (value) => _updateResults(),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               controller: _controllerB,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: 'Input B',
//               ),
//               onChanged: (value) => _updateResults(),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: 'Sum',
//               ),
//               controller: TextEditingController(text: _sum.toString()),
//             ),
//             SizedBox(height: 16.0),
//             TextField(
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: 'Product',
//               ),
//               controller: TextEditingController(text: _product.toString()),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//

class GeoLocationApp extends StatefulWidget {
  const GeoLocationApp({Key? key}) : super(key: key);

  @override
  State<GeoLocationApp> createState() => _GeoLocationAppState();
}

class _GeoLocationAppState extends State<GeoLocationApp> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _currentAddress = "";
  bool sectionEnabled = false;
  bool ENAunit = false;
  bool reverseCalc = false;
  final Calculator _calculator = Calculator();

  String dropdownValue = 'P';
  String enaDropdownValue = 'A';
  int selectedRadio = 1;

  // Text Editing Controllers for Lat-Lon-Alt to E-N-A interconversion
  TextEditingController pointLatConvertConttroller = TextEditingController();
  TextEditingController pointLonConvertController = TextEditingController();
  TextEditingController pointAltConvertConttroller = TextEditingController();
  TextEditingController pointEastConvertConttroller = TextEditingController();
  TextEditingController pointNortConvertController = TextEditingController();
  TextEditingController pointZoneConvertController = TextEditingController();

  // Text Editing Controllers for finding Range, Bearing,AOS from Lar-Lon-Alt to E-N-A interconversion
  TextEditingController point1LatController = TextEditingController();
  TextEditingController point1LonController = TextEditingController();
  TextEditingController point1AltController = TextEditingController();

  TextEditingController point1EastingController = TextEditingController();
  TextEditingController point1NorthingController = TextEditingController();
  TextEditingController point1ZoneController = TextEditingController();

  TextEditingController point2LatController = TextEditingController();
  TextEditingController point2LonController = TextEditingController();
  TextEditingController point2AltController = TextEditingController();

  TextEditingController point2EastingController = TextEditingController();
  TextEditingController point2NorthingController = TextEditingController();
  TextEditingController point2ZoneController = TextEditingController();

  TextEditingController distanceController = TextEditingController();
  TextEditingController rangeController = TextEditingController();
  TextEditingController bearingController = TextEditingController();
  TextEditingController aosController = TextEditingController();

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // isse interactive box ayega for asking permission
    }

    return Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  void _updateResults() {
    final double pointLatForConversion =
        double.tryParse(pointLatConvertConttroller.text) ?? 0.0;
    final double pointLonForConversion =
        double.tryParse(pointLonConvertController.text) ?? 0.0;

    final double point1LatForRange =
        double.tryParse(point1LatController.text) ?? 0.0;
    final double point1LonForRange =
        double.tryParse(point1LonController.text) ?? 0.0;
    final double point1AltForRange =
        double.tryParse(point1AltController.text) ?? 0.0;
    final double point2LatForRange =
        double.tryParse(point2LatController.text) ?? 0.0;
    final double point2LonForRange =
        double.tryParse(point2LonController.text) ?? 0.0;
    final double point2AltForRange =
        double.tryParse(point2AltController.text) ?? 0.0;

    final results;
    final zone;
    final distance;
    final bearing;

    if (sectionEnabled) {
      zone = _calculator.calculateZone(
          pointLatForConversion, pointLonForConversion);
      results = _calculator.calculateENA(
          pointLatForConversion, pointLonForConversion);
    } else {
      zone = _calculator.calculateZone(
          pointLatForConversion, pointLonForConversion);
      results = _calculator.calculateENA(
          pointLatForConversion, pointLonForConversion);
    }

    bearing = _calculator.calculateMapBearing(point1LatForRange,
        point1LonForRange, point2LatForRange, point2LonForRange);
    distance = _calculator.calculateDistanceLatLonAlt(
        point1LatForRange,
        point1LonForRange,
        point1AltForRange,
        point2LatForRange,
        point2LonForRange,
        point2AltForRange);

    setState(() {
      pointZoneConvertController.text = (zone['zone'] ?? 0.0).toString();
      pointEastConvertConttroller.text = (results['easting'] ?? 0.0).toString();
      pointNortConvertController.text = (results['northing'] ?? 0.0).toString();
      print("object clanc");
      distanceController.text = (distance['distance'] ?? 0.0).toStringAsFixed(1);
      rangeController.text = (distance['distance'] ?? 0.0).toStringAsFixed(1);
      bearingController.text = (bearing['bearing'] ?? 0.0).toString();
      print(distanceController.text.toString());
      print(bearingController.text.toString());
      print("done broo");
    });
  }

  @override
  void dispose() {
    // pointLatConvertConttroller.dispose();
    // pointLonConvertController.dispose();
    // super.dispose();
  }

  Future<void> _initializeLocation() async {
    _currentLocation = await _getCurrentLocation();
    await _getAddressFromCoordinates();
    setState(() {});
  }

  Color buttonColor = Color.fromRGBO(203, 219, 188, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 5, 16.0, 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Spacer(flex: 1), // Add a Spacer with flex: 1
                DropdownButton<String>(
                  value: dropdownValue,
                  items: [
                    DropdownMenuItem(
                      value: 'P',
                      child: Text('Projection'),
                    ),
                    DropdownMenuItem(
                      value: 'C',
                      child: Text('Conversion'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                      sectionEnabled = dropdownValue == 'C';
                      if (!sectionEnabled) {
                        point1LatController.text = '';
                        point1LonController.text = '';
                        point2LatController.text = '';
                        point2LonController.text = '';
                      }
                    });
                  },
                ),
                Spacer(flex: 7), // Add a Spacer with flex: 1
                RoundedIconButton(
                  icon: Icons.navigation_sharp,
                  onPressed: () {
                    print('Button Pressed!');
                    setState(() {});
                  },
                ),
                SizedBox(width:5,),
                Spacer(flex: 1), // Add a Spacer with flex: 1
                DropdownButton<String>(
                  value: enaDropdownValue,
                  items: [
                    DropdownMenuItem(
                      value: 'A',
                      child: Text('Primary Unit'),
                    ),
                    DropdownMenuItem(
                      value: 'B',
                      child: Text('Secondary Unit'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      enaDropdownValue = newValue!;
                      ENAunit = enaDropdownValue == 'B';
                    });
                  },
                ),
                Spacer(flex: 1), // Add a Spacer with flex: 1
              ],
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 15.0),
          //   child: const Divider(
          //     color: Color(0xCC4C4C4C), // Color of the line
          //     thickness: 0.5, // Thickness of the line
          //   ),
          // ),
          // Conversion between Lat-Lon-Alt to ENA and vice versa
          if (sectionEnabled && !ENAunit)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point : ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: pointLatConvertConttroller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: !ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Lat 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: pointLonConvertController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: !ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Lon 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: pointAltConvertConttroller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: !ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Alt',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point : ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 45,
                        child: TextField(
                          controller: pointZoneConvertController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: ENAunit,
                          decoration: InputDecoration(
                            labelText: 'A1', // "12-34567 E"  Easting
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: pointNortConvertController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: ENAunit,
                          decoration: InputDecoration(
                            labelText: '  -  E', // "12-34567 E"  Easting
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: pointEastConvertConttroller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: ENAunit,
                          decoration: InputDecoration(
                            labelText: '  -  N', // "12-34567 N" Northing
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: pointAltConvertConttroller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Alt',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (sectionEnabled && ENAunit)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point :",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point1LatController,
                          enabled: !ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Lat 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point1LonController,
                          enabled: !ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Lon 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point1AltController,
                          enabled: !ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Alt 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point :",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      DropdownMenuExample(), // may get difficult to use
                      // this value for reverse calculation
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point1EastingController,
                          enabled: ENAunit,
                          decoration: InputDecoration(
                            labelText: '  -  E', // "12-34567 E"  Easting
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point1NorthingController,
                          enabled: ENAunit,
                          decoration: InputDecoration(
                            labelText: '  -  N', // "12-34567 N" Northing
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point1AltController,
                          enabled: ENAunit,
                          decoration: InputDecoration(
                            labelText: 'Alt 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Calculations from Lat-Lon-Alt & ENA values as input
          // if (!sectionEnabled && !reverseCalc && ENAunit)
          if (!sectionEnabled && ENAunit)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        child: Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value as int;
                              reverseCalc = !reverseCalc;
                            });
                          },
                        ),
                      ),
                      Text(
                        "Point A: ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 5, top: 0)),
                      DropdownMenuExample(),
                      Padding(padding: EdgeInsets.only(left: 5, top: 0)),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point1LatController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Easting',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 100,
                        child: TextField(
                          controller: point1LonController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Northing',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point1AltController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Altitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 4, 0, 4)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Text(
                        "Point B: ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top:4),),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 5, top: 0)),
                      DropdownMenuExample(),
                      Padding(padding: EdgeInsets.only(left: 5, top: 0)),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point2LatController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 1,
                          decoration: InputDecoration(
                            labelText: 'Easting',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 100,
                        child: TextField(
                          controller: point2LonController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 1,
                          decoration: InputDecoration(
                            labelText: 'Northing',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point2AltController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 1,
                          decoration: InputDecoration(
                            labelText: 'Altitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 0)),
                      SizedBox(
                        height: 30,
                        child: Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value as int;
                              reverseCalc = !reverseCalc;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        width: 95,
                        child: Text(
                          "Map Range",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 160,
                        child: TextField(
                          controller: distanceController,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 2,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          // enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Map Range (km)',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Container(
                        width: 95,
                        child: Text(
                          "Aerial Range",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 160,
                        child: TextField(
                          controller: rangeController,
                          enabled: selectedRadio == 2,
                          decoration: InputDecoration(
                            labelText: 'Aerial Range (km)',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Container(
                        width: 95,
                        child: Text(
                          "Bearing",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleDeg2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: ' dd °',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleMin2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: " min '",
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Container(
                        width: 95,
                        child: Text(
                          "AOS",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleDeg2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: ' dd °',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleMin2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: " min '",
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
/*          if (!sectionEnabled && reverseCalc && ENAunit)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point 1: ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      DropdownMenuExample(),
                      // Container(
                      //   height: 30,
                      //   width: 45,
                      //   child: TextField(
                      //     controller: point1ZoneController,
                      //     enabled: ENAunit && reverseCalc,
                      //     decoration: InputDecoration(
                      //       labelText: 'A1',
                      //       border: OutlineInputBorder(),
                      //     ),
                      //   ),
                      // ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point1EastingController,
                          enabled: ENAunit && reverseCalc,
                          decoration: InputDecoration(
                            labelText: '  -  E', // "12-34567 E"  Easting
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point1NorthingController,
                          enabled: ENAunit && reverseCalc,
                          decoration: InputDecoration(
                            labelText: '  -  N', // "12-34567 N" Northing
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point1AltController,
                          enabled: ENAunit && reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Alt 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point 2:",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 45,
                        child: TextField(
                          controller: point1ZoneController,
                          enabled: ENAunit && !reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'A1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point2EastingController,
                          enabled: ENAunit && !reverseCalc,
                          decoration: InputDecoration(
                            labelText: '  -  E', // "12-34567 E"  Easting
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point2NorthingController,
                          enabled: ENAunit && !reverseCalc,
                          decoration: InputDecoration(
                            labelText: '  -  N', // "12-34567 N" Northing
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point2AltController,
                          enabled: ENAunit && !reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Alt 2',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "Distance:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: distanceController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: !reverseCalc
                                ? 'Calculated distance'
                                : 'Enter distance',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "Range:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: rangeController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: !reverseCalc
                                ? 'Calculated range'
                                : 'Enter range', // "417"
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "Bearing:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: bearingController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: !reverseCalc
                                ? 'Calculated bearing'
                                : 'Enter bearing', //"4712356"
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "AOS:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: aosController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: !reverseCalc
                                ? 'Calculated AOS'
                                : 'Enter AOS', //"47.6"
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (!sectionEnabled && reverseCalc && !ENAunit)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point 1: ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point1LatController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Lat 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point1LonController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Lon 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point1AltController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Alt 1',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Text(
                        "Point 2:",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point2LatController,
                          enabled: !reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Lat 2',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point2LonController,
                          enabled: !reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Lon 2',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(7)),
                      Container(
                        height: 30,
                        width: 70,
                        child: TextField(
                          controller: point2AltController,
                          enabled: !reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Alt 2',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "Distance:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: distanceController,
                          enabled: reverseCalc, // reverseCalc
                          decoration: InputDecoration(
                            labelText: 'Enter distance',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "Range:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: rangeController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Enter range', // "471"
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "Bearing:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: bearingController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Enter bearing', //"4712356"
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Container(
                        width: 75,
                        child: Text(
                          "AOS:",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 165,
                        child: TextField(
                          controller: aosController,
                          enabled: reverseCalc,
                          decoration: InputDecoration(
                            labelText: 'Enter AOS', //"47.6"
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),*/
          // if (!sectionEnabled && !reverseCalc && !ENAunit)
          if (!sectionEnabled && !ENAunit)
            // Container(
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Padding(padding: EdgeInsets.only(left: 30)),
            //           Text(
            //             "Point 1: ",
            //             style: GoogleFonts.redHatDisplay(
            //               fontWeight: FontWeight.w900,
            //               color: const Color(0xFF4C4C4C),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(7)),
            //           Container(
            //             height: 30,
            //             width: 70,
            //             child: TextField(
            //               controller: point1LatController,
            //               keyboardType: TextInputType.number,
            //               onChanged: (value) => _updateResults(),
            //               enabled: !sectionEnabled && !ENAunit,
            //               decoration: InputDecoration(
            //                 labelText: 'Lat 1',
            //                 border: OutlineInputBorder(),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(7)),
            //           Container(
            //             height: 30,
            //             width: 70,
            //             child: TextField(
            //               controller: point1LonController,
            //               keyboardType: TextInputType.number,
            //               onChanged: (value) => _updateResults(),
            //               enabled: !sectionEnabled && !ENAunit,
            //               decoration: InputDecoration(
            //                 labelText: 'Lon 1',
            //                 border: OutlineInputBorder(),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(7)),
            //           Container(
            //             height: 30,
            //             width: 70,
            //             child: TextField(
            //               controller: point1AltController,
            //               keyboardType: TextInputType.number,
            //               onChanged: (value) => _updateResults(),
            //               enabled: !sectionEnabled && !ENAunit,
            //               decoration: InputDecoration(
            //                 labelText: 'Alt 1',
            //                 border: OutlineInputBorder(),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
            //       Row(
            //         children: [
            //           Padding(padding: EdgeInsets.only(left: 30)),
            //           Text(
            //             "Point 2:",
            //             style: GoogleFonts.redHatDisplay(
            //               fontWeight: FontWeight.w900,
            //               color: const Color(0xFF4C4C4C),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(7)),
            //           Container(
            //             height: 30,
            //             width: 70,
            //             child: TextField(
            //               controller: point2LatController,
            //               keyboardType: TextInputType.number,
            //               onChanged: (value) => _updateResults(),
            //               enabled: !sectionEnabled && !ENAunit,
            //               decoration: InputDecoration(
            //                 labelText: 'Lat 2',
            //                 border: OutlineInputBorder(),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(7)),
            //           Container(
            //             height: 30,
            //             width: 70,
            //             child: TextField(
            //               controller: point2LonController,
            //               keyboardType: TextInputType.number,
            //               onChanged: (value) => _updateResults(),
            //               enabled: !sectionEnabled && !ENAunit,
            //               decoration: InputDecoration(
            //                 labelText: 'Lon 2',
            //                 border: OutlineInputBorder(),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(7)),
            //           Container(
            //             height: 30,
            //             width: 70,
            //             child: TextField(
            //               controller: point2AltController,
            //               keyboardType: TextInputType.number,
            //               onChanged: (value) => _updateResults(),
            //               enabled: !sectionEnabled && !ENAunit,
            //               decoration: InputDecoration(
            //                 labelText: 'Alt 2',
            //                 border: OutlineInputBorder(),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
            //       Row(
            //         children: [
            //           Padding(padding: EdgeInsets.only(left: 30)),
            //           Container(
            //             width: 95,
            //             child: Text(
            //               "Map Range",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 5,
            //             child: Text(
            //               ":",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(10)),
            //           Container(
            //             height: 30,
            //             width: 160,
            //             child: TextField(
            //               controller: distanceController,
            //               onChanged: (value) => _updateResults(),
            //               enabled: sectionEnabled,
            //               decoration: InputDecoration(
            //                 labelText: 'Map Range (km)',
            //                 border: OutlineInputBorder(),
            //                 disabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.blue),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
            //       Row(
            //         children: [
            //           Padding(padding: EdgeInsets.only(left: 30)),
            //           Container(
            //             width: 95,
            //             child: Text(
            //               "Aerial Range",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 5,
            //             child: Text(
            //               ":",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(10)),
            //           Container(
            //             height: 30,
            //             width: 160, // 165
            //             child: TextField(
            //               controller: rangeController,
            //               enabled: sectionEnabled,
            //               decoration: InputDecoration(
            //                 // labelText: 'Calculated range ', // "471"
            //                 labelText: 'Aerial Range (km)',
            //                 border: OutlineInputBorder(),
            //                 disabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.blue),
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //       Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
            //       Row(
            //         children: [
            //           Padding(padding: EdgeInsets.only(left: 30)),
            //           Container(
            //             width: 95,
            //             child: Text(
            //               "Bearing",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 5,
            //             child: Text(
            //               ":",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(10)),
            //           Container(
            //             height: 30,
            //             width: 60,
            //             child: TextField(
            //               // controller: _angleDeg2Controller,
            //               enabled: sectionEnabled,
            //               style: TextStyle(
            //                 fontSize: 10.0, // Set the font size here
            //               ),
            //               decoration: InputDecoration(
            //                 labelText: ' dd °',
            //                 border: OutlineInputBorder(),
            //                 disabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.blue),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 40,
            //           ),
            //           Container(
            //             height: 30,
            //             width: 60,
            //             child: TextField(
            //               // controller: _angleMin2Controller,
            //               enabled: sectionEnabled,
            //               style: TextStyle(
            //                 fontSize: 10.0, // Set the font size here
            //               ),
            //               decoration: InputDecoration(
            //                 labelText: " min '",
            //                 border: OutlineInputBorder(),
            //                 disabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.blue),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           // Container(
            //           //   height: 30,
            //           //   width: 165,
            //           //   child: TextField(
            //           //     controller: bearingController,
            //           //     enabled: sectionEnabled,
            //           //     decoration: InputDecoration(
            //           //       labelText: 'Calculated bearing', //"4712356"
            //           //       border: OutlineInputBorder(),
            //           //       disabledBorder: OutlineInputBorder(
            //           //         borderSide: BorderSide(color: Colors.blue),
            //           //       ),
            //           //     ),
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //       Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
            //       Row(
            //         children: [
            //           Padding(padding: EdgeInsets.only(left: 30)),
            //           Container(
            //             width: 95,
            //             child: Text(
            //               "AOS",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Container(
            //             width: 5,
            //             child: Text(
            //               ":",
            //               style: GoogleFonts.redHatDisplay(
            //                 fontWeight: FontWeight.w900,
            //                 color: const Color(0xFF4C4C4C),
            //               ),
            //             ),
            //           ),
            //           Padding(padding: EdgeInsets.all(10)),
            //           Container(
            //             height: 30,
            //             width: 60,
            //             child: TextField(
            //               // controller: _angleDeg2Controller,
            //               enabled: sectionEnabled,
            //               style: TextStyle(
            //                 fontSize: 10.0, // Set the font size here
            //               ),
            //               decoration: InputDecoration(
            //                 labelText: ' dd °',
            //                 border: OutlineInputBorder(),
            //                 disabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.blue),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 40,
            //           ),
            //           Container(
            //             height: 30,
            //             width: 60,
            //             child: TextField(
            //               // controller: _angleMin2Controller,
            //               enabled: sectionEnabled,
            //               style: TextStyle(
            //                 fontSize: 10.0, // Set the font size here
            //               ),
            //               decoration: InputDecoration(
            //                 labelText: " min '",
            //                 border: OutlineInputBorder(),
            //                 disabledBorder: OutlineInputBorder(
            //                   borderSide: BorderSide(color: Colors.blue),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           // Container(
            //           //   height: 30,
            //           //   width: 165,
            //           //   child: TextField(
            //           //     controller: aosController,
            //           //     enabled: sectionEnabled,
            //           //     decoration: InputDecoration(
            //           //       labelText: 'Calculated AOS ', //"47.6"
            //           //       border: OutlineInputBorder(),
            //           //       disabledBorder: OutlineInputBorder(
            //           //         borderSide: BorderSide(color: Colors.blue),
            //           //       ),
            //           //     ),
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 30,
                        child: Radio(
                          value: 1,
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value as int;
                              reverseCalc = !reverseCalc;
                            });
                          },
                        ),
                      ),
                      Text(
                        "Point A: ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 55, top: 0)),
                      // DropdownMenuExample(), ke liye 45 width
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point1LatController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 100,
                        child: TextField(
                          controller: point1LonController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point1AltController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: true,
                          decoration: InputDecoration(
                            labelText: 'Altitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 4, 0, 4)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Text(
                        "Point B: ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top:4),),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 55)),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point2LatController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 1,
                          decoration: InputDecoration(
                            labelText: 'Latitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 100,
                        child: TextField(
                          controller: point2LonController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 1,
                          decoration: InputDecoration(
                            labelText: 'Longitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(5, 2, 5, 2)),
                      Container(
                        height: 30,
                        width: 90,
                        child: TextField(
                          controller: point2AltController,
                          keyboardType: TextInputType.number,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 1,
                          decoration: InputDecoration(
                            labelText: 'Altitude',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 0)),
                      SizedBox(
                        height: 30,
                        child: Radio(
                          value: 2,
                          groupValue: selectedRadio,
                          onChanged: (value) {
                            setState(() {
                              selectedRadio = value as int;
                              reverseCalc = !reverseCalc;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 40,),
                      Container(
                        width: 95,
                        child: Text(
                          "Map Range",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 160,
                        child: TextField(
                          controller: distanceController,
                          onChanged: (value) => _updateResults(),
                          enabled: selectedRadio == 2,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          // enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Map Range (km)',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Container(
                        width: 95,
                        child: Text(
                          "Aerial Range",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 160,
                        child: TextField(
                          controller: rangeController,
                          enabled: selectedRadio == 2,
                          decoration: InputDecoration(
                            labelText: 'Aerial Range (km)',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Container(
                        width: 95,
                        child: Text(
                          "Bearing",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleDeg2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: ' dd °',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleMin2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: " min '",
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 6, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 50)),
                      Container(
                        width: 95,
                        child: Text(
                          "AOS",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Container(
                        width: 5,
                        child: Text(
                          ":",
                          style: GoogleFonts.redHatDisplay(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF4C4C4C),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleDeg2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: ' dd °',
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          // controller: _angleMin2Controller,
                          enabled: selectedRadio == 2,
                          style: TextStyle(
                            fontSize: 10.0, // Set the font size here
                          ),
                          decoration: InputDecoration(
                            labelText: " min '",
                            border: OutlineInputBorder(),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}

class GeoLocationCameraOn extends StatefulWidget {
  const GeoLocationCameraOn({Key? key}) : super(key: key);

  @override
  State<GeoLocationCameraOn> createState() => _GeoLocationCameraOnState();
}

class _GeoLocationCameraOnState extends State<GeoLocationCameraOn> {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _currentAddress = "";
  bool sectionEnabled = true;
  TextEditingController point1LatController = TextEditingController();
  TextEditingController point1LonController = TextEditingController();
  TextEditingController point2LatController = TextEditingController();
  TextEditingController point2LonController = TextEditingController();

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // isse interactive box ayega for asking permission
    }

    return Geolocator.getCurrentPosition();
  }

  _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    _currentLocation = await _getCurrentLocation();
    await _getAddressFromCoordinates();
    setState(() {});
  }

  Color buttonColor = Color.fromRGBO(203, 219, 188, 60);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'P',
                  style: TextStyle(
                    color: Colors.white, // Set the color to white
                  ),
                ),
                Switch(
                  value: sectionEnabled,
                  activeColor: Color.fromRGBO(203, 219, 188, 10),
                  inactiveTrackColor: Colors.grey.shade400,
                  onChanged: (value) {
                    setState(() {
                      sectionEnabled = value;
                      if (!sectionEnabled) {
                        point1LatController.text = '';
                        point1LonController.text = '';
                        point2LatController.text = '';
                        point2LonController.text = '';
                      }
                    });
                  },
                ),
                Text(
                  'C',
                  style: TextStyle(
                    color: Colors.white, // Set the color to white
                  ),
                )
              ],
            ),
          ),
          if (!sectionEnabled)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      SizedBox(
                        width: 50,
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Lat",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 38,
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Lon",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Alt",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      Text(
                        "Point 1:",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.latitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.longitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "471",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      Text(
                        "Point 2:",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.latitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.longitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "471",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (sectionEnabled)
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      Text(
                        "Point 1: ",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 35,
                        width: 80,
                        child: TextField(
                          controller: point1LatController,
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Lat 1',
                            labelStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the default border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when enabled
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when focused
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 35,
                        width: 80,
                        child: TextField(
                          controller: point1LonController,
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Lon 1',
                            labelStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the default border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when enabled
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when focused
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      Text(
                        "Point 2:",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 35,
                        width: 80,
                        child: TextField(
                          controller: point2LatController,
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Lat 2',
                            labelStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the default border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when enabled
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when focused
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 35,
                        width: 80,
                        child: TextField(
                          controller: point2LonController,
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Lon 2',
                            labelStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the default border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when enabled
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when focused
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35)),
                      Text(
                        "Distance:",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Container(
                        height: 35,
                        width: 167,
                        child: TextField(
                          controller: point2LonController,
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated distance ',
                            labelStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the default border color
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when enabled
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .white60, // Set the border color when focused
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Padding(padding: EdgeInsets.fromLTRB(0, 12, 0, 0)),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 35)),
              Text(
                "Range:",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "471",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 0)),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 35)),
              Text(
                "Bearing:",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "4712356",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 2, 0, 0)),
          Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 35)),
              Text(
                "AOS:",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "47.1",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
