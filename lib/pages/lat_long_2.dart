import 'package:arnv/pages/altitude.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class GeoLocationApp2 extends StatefulWidget {
  const GeoLocationApp2({Key? key}) : super(key: key);
  @override
  State<GeoLocationApp2> createState() => _GeoLocationApp2State();
}

class _GeoLocationApp2State extends State<GeoLocationApp2> {
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
          Padding(padding: EdgeInsets.all(5)),
          Column(
            children: [
              //Padding(padding: EdgeInsets.only(left: 50)),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.42)),
                  Text(
                    "Lat:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF4C4C4C),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${_currentLocation?.latitude.toStringAsPrecision(7)}",
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
                          left: MediaQuery.of(context).size.width * 0.42)),
                  Text(
                    "Lon:",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF4C4C4C),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${_currentLocation?.longitude.toStringAsPrecision(7)}",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF4C4C4C),
                    ),
                  ),
                ],
              ),
              AltitudeScreen(),
            ],
          ),
        ],
      ),
    );
  }
}
