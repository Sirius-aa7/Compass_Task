import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'altitude.dart';

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



class GeoLocationApp3 extends StatefulWidget {
  const GeoLocationApp3({Key? key}) : super(key: key);
  @override
  State<GeoLocationApp3> createState() => _GeoLocationApp3State();
}

class _GeoLocationApp3State extends State<GeoLocationApp3> {
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
                      color: Colors.white,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(3)),
                  Text(
                    "${_currentLocation?.latitude.toStringAsPrecision(7)}",
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
                          left: MediaQuery.of(context).size.width * 0.42)),
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
                    "${_currentLocation?.longitude.toStringAsPrecision(7)}",
                    style: GoogleFonts.redHatDisplay(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              AltitudeScreen2(),
              Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.42)),
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
                          left: MediaQuery.of(context).size.width * 0.42)),
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
                          left: MediaQuery.of(context).size.width * 0.42)),
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
                    "${_currentLocation?.longitude.toStringAsPrecision(3)}",
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
