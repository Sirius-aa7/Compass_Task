import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class GPSDemo extends StatefulWidget {
  @override
  _GPSDemoState createState() => _GPSDemoState();
}

class _GPSDemoState extends State<GPSDemo> {
  Position? _position;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Color buttonColor = Color.fromRGBO(203, 219, 188, 60);

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }

    _position = await Geolocator.getCurrentPosition();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(5)),
          Column(
            children: [
              //Padding(padding: EdgeInsets.only(left: 50)),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42)),
                  Text(
                    "Lat:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${_position?.latitude?.toStringAsPrecision(7)}",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42)),
                  Text(
                    "Lon:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${_position?.longitude?.toStringAsPrecision(7)}",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42)),
                  Text(
                    "Alt:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${_position?.altitude?.toInt()} m",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              //AltitudeScreen2(),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42)),
                  Text(
                    "Easting:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "112233",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42)),
                  Text(
                    "Northing:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "1234567",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery
                              .of(context)
                              .size
                              .width * 0.42)),
                  Text(
                    "Speed:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${_position?.altitude?.toInt()} m",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}