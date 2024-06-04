import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class GeoLocationApp2 extends StatefulWidget {
  const GeoLocationApp2({Key? key}) : super(key: key);
  @override
  State<GeoLocationApp2> createState() => _GeoLocationApp2State();
}

class _GeoLocationApp2State extends State<GeoLocationApp2> {
  Position? _position;
  bool _primaryUnitsLatLon = true; // Flag to control which information to display

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
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _primaryUnitsLatLon = !_primaryUnitsLatLon; // Toggle the flag on tap
        });
      },
      child: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(5)),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.42),
                    ),
                    Text(
                      _primaryUnitsLatLon ? "Latitude:" : "Easting:",
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      _primaryUnitsLatLon
                          ? "${_position?.latitude?.toStringAsPrecision(7)}"
                          : "112233", // Placeholder for Easting
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.42),
                    ),
                    Text(
                      _primaryUnitsLatLon ? "Longitude:" : "Northing:",
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      _primaryUnitsLatLon
                          ? "${_position?.longitude?.toStringAsPrecision(7)}"
                          : "1234567", // Placeholder for Northing
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.42),
                    ),
                    Text(
                      "Altitude:",
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      "${_position?.altitude?.toInt()} m",
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.42),
                    ),
                    Text(
                      "Speed:",
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(3)),
                    Text(
                      "${_position?.speed?.toStringAsFixed(2) ?? '0'} m/s",
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF4C4C4C),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}