import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

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
                Text('C')
              ],
            ),
          ),

          if(!sectionEnabled)
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
                          color: const Color(0xFF4C4C4C),
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
                          color: const Color(0xFF4C4C4C),
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
                          color: const Color(0xFF4C4C4C),
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
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.latitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.longitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "471",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
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
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.latitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "${_currentLocation?.longitude.toStringAsPrecision(7)}",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "471",
                        style: GoogleFonts.redHatDisplay(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF4C4C4C),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          if(sectionEnabled)
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
                          color: const Color(0xFF4C4C4C),
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
                            border: OutlineInputBorder(),
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
                            border: OutlineInputBorder(),
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
                          color: const Color(0xFF4C4C4C),
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
                            border: OutlineInputBorder(),
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
                            border: OutlineInputBorder(),
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
                          color: const Color(0xFF4C4C4C),
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
                            border: OutlineInputBorder(),
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
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "471",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
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
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "4712356",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
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
                  color: const Color(0xFF4C4C4C),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "47.1",
                style: GoogleFonts.redHatDisplay(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF4C4C4C),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
