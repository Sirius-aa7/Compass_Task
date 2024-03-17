import 'package:flutter/cupertino.dart';
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
          Padding(padding: EdgeInsets.all(10)),
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
          Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
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
