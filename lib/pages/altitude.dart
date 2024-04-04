import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class AltitudeScreen extends StatefulWidget {
  @override
  _AltitudeScreenState createState() => _AltitudeScreenState();
}

class _AltitudeScreenState extends State<AltitudeScreen> {
  double? _currentAltitude;
  int? _currentAltitude2;

  @override
  void initState() {
    super.initState();
    _getAltitude();
  }

  Future<void> _getAltitude() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        _currentAltitude = position.altitude;
        _currentAltitude2 = _currentAltitude?.toInt();
      });

      print("Altitude: $_currentAltitude meters");

      // Now you can use _currentAltitude as needed
    } catch (e) {
      print("Error getting altitude: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: //Text('Altitude: $_currentAltitude meters'),
          Row(
        children: [
          Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width) *
                      0.42),
          Text(
            "Alt:",
            style: GoogleFonts.redHatDisplay(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF4C4C4C),
            ),
          ),
          Padding(padding: EdgeInsets.all(3)),
          Text(
            "$_currentAltitude2  m",
            style: GoogleFonts.redHatDisplay(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF4C4C4C),
            ),
          ),
        ],
      ),
    );
  }
}


class AltitudeScreen2 extends StatefulWidget {
  @override
  _AltitudeScreenState2 createState() => _AltitudeScreenState2();
}

class _AltitudeScreenState2 extends State<AltitudeScreen2> {
  double? _currentAltitude;
  int? _currentAltitude2;

  @override
  void initState() {
    super.initState();
    _getAltitude();
  }

  Future<void> _getAltitude() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        _currentAltitude = position.altitude;
        _currentAltitude2 = _currentAltitude?.toInt();
      });

      print("Altitude: $_currentAltitude meters");

      // Now you can use _currentAltitude as needed
    } catch (e) {
      print("Error getting altitude: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: //Text('Altitude: $_currentAltitude meters'),
      Row(
        children: [
          Padding(
              padding:
              EdgeInsets.only(left: MediaQuery.of(context).size.width) *
                  0.42),
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
            "$_currentAltitude2  m",
            style: GoogleFonts.redHatDisplay(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
