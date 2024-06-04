import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dropdownENA.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('P'),
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
                Text('C'),
                SizedBox(
                  width: 50,
                ),
                Text('R'),
                Switch(
                  value: reverseCalc,
                  activeColor: Color.fromRGBO(203, 219, 188, 10),
                  inactiveTrackColor: Colors.grey.shade400,
                  onChanged: (value) {
                    setState(() {
                      reverseCalc = value;
                    });
                  },
                ),
                Text('S'),
                SizedBox(
                  width: 50,
                ),
                Text('A'),
                Switch(
                  value: ENAunit,
                  activeColor: Color.fromRGBO(203, 219, 188, 10),
                  inactiveTrackColor: Colors.grey.shade400,
                  onChanged: (value) {
                    setState(() {
                      ENAunit = value;
                    });
                  },
                ),
                Text('B')
              ],
            ),
          ),
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
                          controller: point1EastingController,
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
          if (!sectionEnabled && !reverseCalc && ENAunit)
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
                      DropdownMenuExample(),
                      Padding(padding: EdgeInsets.all(5)),
                      Container(
                        height: 30,
                        width: 60,
                        child: TextField(
                          controller: point2EastingController,
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
                          controller: point2NorthingController,
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
                          controller: point2AltController,
                          enabled: ENAunit,
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
                          enabled: sectionEnabled, // reverseCalc
                          decoration: InputDecoration(
                            labelText: 'Calculated distance ',
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
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated range ', // "471"
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
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated bearing', //"4712356"
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
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated AOS ', //"47.6"
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
          if (!sectionEnabled && reverseCalc && ENAunit)
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
            ),
          if (!sectionEnabled && !reverseCalc && !ENAunit)
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
                          enabled: !sectionEnabled && !ENAunit,
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
                          enabled: !sectionEnabled && !ENAunit,
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
                          enabled: !sectionEnabled && !ENAunit,
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
                          enabled: !sectionEnabled && !ENAunit,
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
                          enabled: !sectionEnabled && !ENAunit,
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
                          enabled: !sectionEnabled && !ENAunit,
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
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated distance ',
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
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated range ', // "471"
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
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated bearing', //"4712356"
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
                          enabled: sectionEnabled,
                          decoration: InputDecoration(
                            labelText: 'Calculated AOS ', //"47.6"
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
